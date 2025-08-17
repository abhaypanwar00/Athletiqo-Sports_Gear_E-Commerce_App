import 'package:athletiqo/modules/admin/shop/controllers/product/product_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'product_card.dart';

class ProductListView extends StatelessWidget {
  final String category;

  const ProductListView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminProductController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.lime),
        );
      }

      final products = controller.getProductsByCategory(category);

      if (products.isEmpty) {
        return const Center(child: Text("No products available"));
      }

      return ListView.builder(
        padding: EdgeInsets.only(
          left: AppSizes.defaultSpace,
          right: AppSizes.defaultSpace,
          top: AppSizes.sm,
        ),
        itemCount: products.length,
        itemBuilder: (_, index) => AdminProductCard(product: products[index]),
      );
    });
  }
}
