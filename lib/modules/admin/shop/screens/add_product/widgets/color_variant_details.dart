import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/color_variant_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';

class ColorVariantDetails extends StatelessWidget {
  ColorVariantDetails({super.key});

  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children:
            controller.selectedColors.map((color) {
              final details = controller.colorDetails[color]!;

              return ColorVariantTile(
                color: color,
                subcategory: controller.selectedSubcategory.value,
                details: details,
                controller: controller,
              );
            }).toList(),
      ),
    );
  }
}
