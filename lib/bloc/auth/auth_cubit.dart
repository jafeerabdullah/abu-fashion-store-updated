import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';
import '../../data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.getCurrentUserModel();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (_) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.login(email, password);
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.signup(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authRepository.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception(_normalizeErrorMessage(e));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(const AuthUnauthenticated());
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (state is! AuthAuthenticated) {
      throw Exception('You need to log in before editing your profile.');
    }

    try {
      final updatedUser = await _authRepository.updateProfile(
        name: name,
        phone: phone,
      );
      emit(AuthAuthenticated(updatedUser));
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception(_normalizeErrorMessage(e));
    }
  }

  Future<void> deleteAccount(String password) async {
    if (state is! AuthAuthenticated) {
      throw Exception('You need to log in before deleting your account.');
    }

    try {
      await _authRepository.deleteAccount(password: password);
      emit(const AuthUnauthenticated());
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception(_normalizeErrorMessage(e));
    }
  }

  String _mapFirebaseError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is disabled in Firebase Console. '
            'Enable it in Authentication > Sign-in method.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      case 'requires-recent-login':
        return 'Please sign in again before deleting your account.';
      case 'invalid-credential':
      case 'invalid-login-credentials':
        return 'The password you entered is incorrect.';
      case 'invalid-api-key':
        return 'Your Firebase API key is invalid. Re-run "flutterfire '
            'configure" and update lib/firebase_options.dart.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication. '
            'Check your Firebase project settings.';
      case 'configuration-not-found':
        return 'Firebase configuration was not found. Re-run "flutterfire '
            'configure" and try again.';
      default:
        final details = error.message?.trim();
        if (details != null && details.isNotEmpty) {
          return details;
        }
        return 'Authentication failed. Please try again.';
    }
  }

  String _normalizeErrorMessage(Object error) {
    final message = error.toString();
    const prefix = 'Exception: ';
    if (message.startsWith(prefix)) {
      return message.substring(prefix.length);
    }
    return message;
  }
}
