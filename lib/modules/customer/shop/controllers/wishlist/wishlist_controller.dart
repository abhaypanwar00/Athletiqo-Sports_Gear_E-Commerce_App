import 'dart:developer';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:athletiqo/modules/customer/repository/wishlist_repository.dart';

class WishlistController extends GetxController {
  final WishlistRepository _wishlistRepo = WishlistRepository();

  // Reactive state
  var wishlistIds = <String>{}.obs;
  var wishlistProducts = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  /// Load wishlist product IDs and fetch their corresponding product details
  Future<void> loadWishlist() async {
    isLoading.value = true;
    try {
      final ids = await _wishlistRepo.getWishlistProductIds();
      wishlistIds.assignAll(ids);

      if (ids.isNotEmpty) {
        final snapshot =
            await FirebaseFirestore.instance
                .collection('products')
                .where(FieldPath.documentId, whereIn: ids)
                .get();

        final products =
            snapshot.docs
                .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
                .toList();

        wishlistProducts.assignAll(products);
      } else {
        wishlistProducts.clear();
      }
    } catch (e) {
      log("Error loading wishlist: $e");
    }
    isLoading.value = false;
  }

  /// Toggle wishlist state for a product
  Future<void> toggleWishlist(String productId) async {
    await _wishlistRepo.toggleWishlist(productId);

    if (wishlistIds.contains(productId)) {
      wishlistIds.remove(productId);
      wishlistProducts.removeWhere((product) => product.id == productId);
    } else {
      wishlistIds.add(productId);
      final doc =
          await FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .get();
      if (doc.exists) {
        final product = ProductModel.fromMap(doc.data()!, doc.id);
        wishlistProducts.add(product);
      }
    }
  }

  /// Check if a product is wishlisted
  bool isWishlisted(String productId) => wishlistIds.contains(productId);
}
