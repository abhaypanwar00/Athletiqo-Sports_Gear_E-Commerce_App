import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/product/product_card.dart';
import 'package:athletiqo/modules/customer/shop/controllers/wishlist/wishlist_controller.dart';
import 'package:athletiqo/modules/customer/shop/screens/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());

    return Scaffold(
      appBar: Appbar(title: 'Wishlist'),
      body: Obx(() {
        if (wishlistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = wishlistController.wishlistProducts;

        if (products.isEmpty) {
          return const Center(child: Text('Your wishlist is empty.'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap:
                  () =>
                      Get.to(() => ProductDetailScreen(productId: product.id)),
              child: ProductCard(product: product),
            );
          },
        );
      }),
    );
  }
}
