import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/product_image_picker.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/size_chips.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';

class ColorVariantTile extends StatelessWidget {
  const ColorVariantTile({
    super.key,
    required this.color,
    required this.subcategory,
    required this.details,
    required this.controller,
  });

  final Color color;
  final String subcategory;
  final Map<String, dynamic> details;
  final AddProductController controller;

  @override
  Widget build(BuildContext context) {
    final images = List<String>.from(details['images'] ?? []);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkGrey, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHeading(
            text:
                '${AppHelperFunctions.getColorName(color) ?? "Color"} ${subcategory.isNotEmpty ? subcategory : ""}'
                    .trim(),
          ),
          SizedBox(height: AppSizes.md),

          // Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeading(text: 'Price'),
              SizedBox(height: AppSizes.sm),
              TextFormField(
                initialValue: controller.colorDetails[color]?['price'] ?? '',
                keyboardType: TextInputType.number,
                validator:
                    (value) => AppValidator.validateEmptyText('Price', value),
                onChanged: (value) {
                  controller.updatePrice(color, value);
                },
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),

          // Size Chips
          SizeChips(controller: controller, details: details, color: color),
          SizedBox(height: AppSizes.md),

          const TextHeading(text: "Images"),
          SizedBox(height: AppSizes.sm),

          // Product Image Picker
          ProductImagePicker(
            images: images,
            controller: controller,
            color: color,
          ),
        ],
      ),
    );
  }
}
