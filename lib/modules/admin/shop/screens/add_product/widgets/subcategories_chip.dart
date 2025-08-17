import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubcategoriesChip extends StatelessWidget {
  SubcategoriesChip({super.key});

  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.subcategories.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextHeading(text: "Subcategory"),
                  SizedBox(height: AppSizes.sm),
                  Wrap(
                    spacing: 10,
                    children:
                        controller.subcategories.map((sub) {
                          return ChoiceChip(
                            label: Text(sub),
                            selected:
                                controller.selectedSubcategory.value == sub,
                            onSelected: (_) {
                              controller.selectedSubcategory.value = sub;
                              controller.subCategoryError.value =
                                  ''; // Clear error
                            },
                          );
                        }).toList(),
                  ),
                  if (controller.subCategoryError.isNotEmpty)
                    ErrorText(
                      controller: controller,
                      text: controller.subCategoryError.value,
                    ),
                ],
              )
              : const SizedBox(),
    );
  }
}
