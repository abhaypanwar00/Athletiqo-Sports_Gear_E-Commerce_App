import 'package:cloud_firestore/cloud_firestore.dart';

class BrandRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateBrand(String brandName) async {
    final docRef = _firestore.collection('brands').doc(brandName);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      await docRef.update({'productCount': FieldValue.increment(1)});
    } else {
      await docRef.set({'brandName': brandName, 'productCount': 1});
    }
  }
}
