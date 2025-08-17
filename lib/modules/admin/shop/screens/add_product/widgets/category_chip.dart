import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChip extends StatelessWidget {
  CategoryChip({super.key});

  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            children:
                ['Clothing', 'Footwear', 'Fitness', 'Accessories']
                    .map(
                      (cat) => ChoiceChip(
                        label: Text(cat),
                        selected: controller.selectedCategory.value == cat,
                        onSelected: (val) {
                          controller.selectedCategory.value = cat;
                          controller.updateSubcategories();
                          controller.categoryError.value =
                              ''; // Clear error when selected
                        },
                      ),
                    )
                    .toList(),
          ),
          if (controller.categoryError.isNotEmpty)
            ErrorText(
              controller: controller,
              text: controller.categoryError.value,
            ),
        ],
      ),
    );
  }
}
