import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductColorPicker extends StatelessWidget {
  ProductColorPicker({super.key});

  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              spacing: 20,
              runSpacing: 15,
              children:
                  controller.availableColors.map((color) {
                    bool isSelected = controller.selectedColors.contains(color);
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          controller.selectedColors.remove(color);
                          controller.colorDetails.remove(color);
                        } else {
                          controller.selectedColors.add(color);
                          controller.colorDetails[color] = {
                            'price': '',
                            'stock': '',
                            'sizes': <String>[],
                            'images': <String>[],
                          };
                          controller.colorError.value = ''; // Clear error
                        }
                      },
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  color:
                                      color == Colors.black
                                          ? Colors.white
                                          : Colors.black,
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppHelperFunctions.getColorName(color) ?? 'Unknown',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
          if (controller.colorError.isNotEmpty)
            ErrorText(
              controller: controller,
              text: controller.colorError.value,
            ),
        ],
      ),
    );
  }
}
