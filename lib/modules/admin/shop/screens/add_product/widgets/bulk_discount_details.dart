import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BulkDiscountDetails extends StatelessWidget {
  BulkDiscountDetails({super.key});

  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkGrey, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeading(text: "Min. Quantity"),
                SizedBox(height: AppSizes.sm),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.minQuantity,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.spaceBtwInputFields),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeading(text: "Discount"),
                SizedBox(height: AppSizes.sm),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.discount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
