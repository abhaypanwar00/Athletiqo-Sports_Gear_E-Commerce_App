import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/stock_inputs.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeChips extends StatelessWidget {
  const SizeChips({
    super.key,
    required this.controller,
    required this.details,
    required this.color,
  });

  final AddProductController controller;
  final Map<String, dynamic> details;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedCategory.isEmpty) return const SizedBox();

      final sizeOptions = controller.getSizeOptions();
      final selectedSizes = List<Map<String, String>>.from(details['sizes']);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHeading(text: "Sizes"),
          SizedBox(height: AppSizes.sm),

          Wrap(
            spacing: 10,
            children:
                sizeOptions.map((size) {
                  final isSelected = selectedSizes.any(
                    (e) => e['size'] == size,
                  );
                  return ChoiceChip(
                    label: Text(size),
                    selected: isSelected,
                    onSelected: (_) {
                      isSelected
                          ? controller.removeSize(color, size)
                          : controller.addSizeWithStock(color, size);
                      controller.sizeError.value = '';
                    },
                  );
                }).toList(),
          ),

          if (controller.sizeError.isNotEmpty)
            ErrorText(controller: controller, text: controller.sizeError.value),

          if (selectedSizes.isNotEmpty) ...[
            SizedBox(height: AppSizes.md),
            StockInputs(color: color, details: details, controller: controller),
          ],
        ],
      );
    });
  }
}
