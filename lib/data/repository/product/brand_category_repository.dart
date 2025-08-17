import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addBrandCategory(String brandName, String categoryName) async {
    final query =
        await _firestore
            .collection('brand_categories')
            .where('brand', isEqualTo: brandName)
            .where('category', isEqualTo: categoryName)
            .limit(1)
            .get();

    if (query.docs.isEmpty) {
      await _firestore.collection('brand_categories').add({
        'brand': brandName,
        'category': categoryName,
      });
    }
  }
}
