import 'package:abu_fashion_store/data/mock/product_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('catalog has ten Unsplash-backed products in each category', () {
    const categories = ['men', 'women', 'kids', 'accessories'];

    for (final category in categories) {
      final products = localProductCatalog.where(
        (product) => product.category == category,
      );

      expect(products.length, 10);
      expect(
        products.every(
          (product) =>
              product.imageUrl.startsWith('https://images.unsplash.com/'),
        ),
        isTrue,
      );
    }
  });
}
