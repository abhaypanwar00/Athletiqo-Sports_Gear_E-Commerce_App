import 'package:athletiqo/common/widgets/layout/dynamic_grid_layout.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/shop/controllers/product/product_controller.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandShowcaseScreen extends StatelessWidget {
  const BrandShowcaseScreen({
    super.key,
    required this.brandName,
    required this.categoryName,
  });

  final String brandName, categoryName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerProductController>();
    final products = controller.getProductsByBrandAndCategory(
      brandName,
      categoryName,
    );
    return Scaffold(
      appBar: Appbar(title: '$brandName $categoryName', showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: DynamicGridLayout(products: products),
        ),
      ),
    );
  }
}
