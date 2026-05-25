import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserModel> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user!;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? 'User',
      email: user.email ?? email,
    );
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user!;
    await user.updateDisplayName(name);

    final userModel = UserModel(
      uid: user.uid,
      name: name,
      email: email.trim(),
      phone: phone,
    );

    try {
      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
    } catch (_) {
      try {
        await user.delete();
      } catch (_) {
        // Keep the original Firestore error so the UI reports the real cause.
      }
      rethrow;
    }

    return userModel;
  }

  Future<UserModel?> getCurrentUserModel() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) return UserModel.fromMap(doc.data()!);
      return UserModel(
        uid: user.uid,
        name: user.displayName ?? 'User',
        email: user.email ?? '',
      );
    } catch (_) {
      return UserModel(
        uid: user.uid,
        name: user.displayName ?? 'User',
        email: user.email ?? '',
      );
    }
  }

  Future<UserModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('You need to log in before updating your profile.');
    }

    final normalizedName = name.trim();
    final normalizedPhone = phone.trim();

    await user.updateDisplayName(normalizedName);

    final docRef = _firestore.collection('users').doc(user.uid);
    final snapshot = await docRef.get();

    final existingUser = snapshot.exists
        ? UserModel.fromMap(snapshot.data()!)
        : UserModel(
            uid: user.uid,
            name: user.displayName ?? normalizedName,
            email: user.email ?? '',
            phone: normalizedPhone,
          );

    final updatedUser = existingUser.copyWith(
      name: normalizedName,
      email: user.email ?? existingUser.email,
      phone: normalizedPhone,
    );

    await docRef.set(updatedUser.toMap(), SetOptions(merge: true));

    return updatedUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final normalizedEmail = email.trim();
    if (normalizedEmail.isEmpty) {
      throw StateError('Please enter your email address.');
    }

    await _auth.sendPasswordResetEmail(email: normalizedEmail);
  }

  Future<void> deleteAccount({required String password}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('You need to log in before deleting your account.');
    }

    final email = user.email;
    if (email == null || email.isEmpty) {
      throw StateError(
        'This account cannot be deleted automatically because it has no email.',
      );
    }

    final normalizedPassword = password.trim();
    if (normalizedPassword.isEmpty) {
      throw StateError('Please enter your password to delete the account.');
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: normalizedPassword,
    );

    await user.reauthenticateWithCredential(credential);

    final userDoc = _firestore.collection('users').doc(user.uid);
    await _deleteCollection(userDoc.collection('orders'));
    await userDoc.delete();
    await user.delete();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> _deleteCollection(
    CollectionReference<Map<String, dynamic>> collection,
  ) async {
    while (true) {
      final snapshot = await collection.limit(50).get();
      if (snapshot.docs.isEmpty) {
        return;
      }

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}
