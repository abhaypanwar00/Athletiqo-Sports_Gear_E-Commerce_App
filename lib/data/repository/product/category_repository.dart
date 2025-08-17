import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addCategoryIfNotExists(String categoryName, String subcategoryName) async {
    final docRef = _firestore.collection('categories').doc(categoryName);

    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      await docRef.set({'categoryName': categoryName, 'subcategories': subcategoryName});
    }
  }
}
