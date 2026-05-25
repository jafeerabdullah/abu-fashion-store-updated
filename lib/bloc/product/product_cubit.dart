import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;
  List<ProductModel> _allProducts = [];
  List<ProductModel> _featured = [];

  ProductCubit(this._repository) : super(const ProductInitial());

  Future<void> loadProducts() async {
    emit(const ProductLoading());
    try {
      _allProducts = await _repository.getAllProducts();
      _featured = _allProducts.where((product) => product.isFeatured).toList();
      emit(ProductsLoaded(products: _allProducts, featured: _featured));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> filterByCategory(String category) async {
    if (state is! ProductsLoaded) return;
    final current = state as ProductsLoaded;
    emit(const ProductLoading());
    try {
      final filtered = category == 'all'
          ? _allProducts
          : _allProducts.where((p) => p.category == category).toList();
      emit(ProductsLoaded(
        products: filtered,
        featured: _featured,
        selectedCategory: category,
        searchQuery: current.searchQuery,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (state is! ProductsLoaded) return;
    final current = state as ProductsLoaded;
    if (query.isEmpty) {
      final filtered = current.selectedCategory == 'all'
          ? _allProducts
          : _allProducts
              .where((p) => p.category == current.selectedCategory)
              .toList();
      emit(ProductsLoaded(
        products: filtered,
        featured: _featured,
        selectedCategory: current.selectedCategory,
        searchQuery: '',
      ));
      return;
    }
    final q = query.toLowerCase();
    final filtered = _allProducts
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
    emit(ProductsLoaded(
      products: filtered,
      featured: _featured,
      selectedCategory: current.selectedCategory,
      searchQuery: query,
    ));
  }
}
