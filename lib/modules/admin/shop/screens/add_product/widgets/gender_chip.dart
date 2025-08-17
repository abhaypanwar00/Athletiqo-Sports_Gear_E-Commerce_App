import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderChip extends StatelessWidget {
  GenderChip({super.key});

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
                ['Male', 'Female', 'Unisex'].map((gender) {
                  return ChoiceChip(
                    label: Text(gender),
                    selected: controller.selectedGender.value == gender,
                    onSelected: (val) {
                      controller.selectedGender.value = gender;
                      controller.updateSubcategories();
                      controller.genderError.value = ''; // Clear error
                    },
                  );
                }).toList(),
          ),
          if (controller.genderError.isNotEmpty)
            ErrorText(
              controller: controller,
              text: controller.genderError.value,
            ),
        ],
      ),
    );
  }
}
