import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brand_repository.dart';
import 'category_repository.dart';
import 'brand_category_repository.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BrandRepository brandRepo = BrandRepository();
  final CategoryRepository categoryRepo = CategoryRepository();
  final BrandCategoryRepository brandCategoryRepo = BrandCategoryRepository();

  Future<void> addProduct(ProductModel product) async {
    try {
      final productRef = _firestore.collection('products').doc(product.id);
      await productRef.set(product.toMap());

      await brandRepo.addOrUpdateBrand(product.brandName);
      await categoryRepo.addCategoryIfNotExists(
        product.category,
        product.subCategory,
      );
      await brandCategoryRepo.addBrandCategory(
        product.brandName,
        product.category,
      );
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
}
