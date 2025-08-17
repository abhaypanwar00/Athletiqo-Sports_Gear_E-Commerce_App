import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';

class AdminProductController extends GetxController {
  static AdminProductController get instance => Get.find();

  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      final snapshot =
          await FirebaseFirestore.instance
              .collection('products')
              .where('isActive', isEqualTo: true)
              .get();

      final products =
          snapshot.docs.map((doc) {
            return ProductModel.fromMap(doc.data(), doc.id);
          }).toList();

      allProducts.assignAll(products);
    } catch (e) {
      log('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<ProductModel> getProductsByCategory(String category) {
    return allProducts
        .where((p) => p.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
