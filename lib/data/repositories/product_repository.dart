import 'package:cloud_firestore/cloud_firestore.dart';
import '../mock/product_catalog.dart';
import '../models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestore.collection('products');

  Future<List<ProductModel>> getAllProducts() async {
    final productsById = <String, ProductModel>{
      for (final product in localProductCatalog) product.id: product,
    };

    try {
      final snapshot = await _productsRef
          .where('isActive', isEqualTo: true)
          .get();

      for (final doc in snapshot.docs) {
        final product = _mapProduct(doc);
        productsById[product.id] = product;
      }
    } on FirebaseException {
      // Keep the built-in catalog available when Firestore is unavailable.
    }

    final products = productsById.values.toList();
    products.sort((a, b) => a.name.compareTo(b.name));
    return products;
  }

  Future<List<ProductModel>> getFeaturedProducts() async {
    final products = await getAllProducts();
    return products.where((product) => product.isFeatured).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final products = await getAllProducts();
    if (category == 'all') return products;
    return products.where((product) => product.category == category).toList();
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final products = await getAllProducts();
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return products;
    }

    return products
        .where(
          (product) =>
              product.name.toLowerCase().contains(normalizedQuery) ||
              product.category.toLowerCase().contains(normalizedQuery) ||
              product.description.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      final directDoc = await _productsRef.doc(id).get();
      if (directDoc.exists) {
        return _mapProduct(directDoc);
      }

      final snapshot = await _productsRef
          .where('id', isEqualTo: id)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return _mapProduct(snapshot.docs.first);
      }
    } on FirebaseException {
      // Fall back to the built-in catalog below.
    }

    for (final product in localProductCatalog) {
      if (product.id == id) return product;
    }
    return null;
  }

  ProductModel _mapProduct(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Product document "${doc.id}" has no data.');
    }

    return ProductModel.fromMap({
      ...data,
      'id': (data['id'] as String?) ?? doc.id,
      'sizes': List<String>.from((data['sizes'] as List?) ?? const []),
    });
  }
}
