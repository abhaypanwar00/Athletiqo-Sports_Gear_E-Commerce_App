import 'package:athletiqo/common/widgets/layout/dynamic_grid_layout.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/shop/controllers/product/product_controller.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key, required this.brandName});

  final String brandName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerProductController>();
    final products = controller.getProductsByBrand(brandName);
    return Scaffold(
      appBar: Appbar(title: brandName, showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: DynamicGridLayout(products: products),
        ),
      ),
    );
  }
}
