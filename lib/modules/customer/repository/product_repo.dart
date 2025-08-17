import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ProductModel> getProductById(String productId) async {
    final doc = await _db.collection('products').doc(productId).get();
    if (!doc.exists) throw Exception("Product not found");
    return ProductModel.fromMap(doc.data()!, doc.id);
  }
}
