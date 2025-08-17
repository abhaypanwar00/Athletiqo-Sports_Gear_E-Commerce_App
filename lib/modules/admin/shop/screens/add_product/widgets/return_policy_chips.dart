import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReturnPolicyChips extends StatelessWidget {
  ReturnPolicyChips({super.key});

  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            children:
                controller.returnPolicies.map((policy) {
                  return ChoiceChip(
                    label: Text(policy),
                    selected: controller.selectedReturnPolicy.value == policy,
                    onSelected: (_) {
                      controller.selectedReturnPolicy.value = policy;
                      controller.policyError.value =
                          ''; // Clear error on selection
                    },
                  );
                }).toList(),
          ),
          if (controller.policyError.isNotEmpty)
            ErrorText(
              controller: controller,
              text: controller.policyError.value,
            ),
        ],
      );
    });
  }
}
