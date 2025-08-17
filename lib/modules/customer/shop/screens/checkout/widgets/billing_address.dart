import 'package:athletiqo/common/widgets/text/section_heading.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/address_controller.dart';
import 'package:athletiqo/modules/customer/personalization/screens/address/address.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());

    return Obx(() {
      final defaultAddress = addressController.addresses.firstWhereOrNull(
        (addr) => addr.isDefault,
      );

      if (defaultAddress == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              text: "Shipping Address",
              showActionButton: true,
              buttonTitle: "Change",
              onPressed: () => Get.to(() => AddressScreen()),
            ),
            SizedBox(height: AppSizes.spaceBtwItems / 2),
            const Text("No default address found."),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            text: "Shipping Address",
            showActionButton: true,
            buttonTitle: "Change",
            onPressed: () {
              Get.to(() => AddressScreen());
            },
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 2),
          Text(
            defaultAddress.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 2),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.grey, size: 16),
              SizedBox(width: AppSizes.spaceBtwItems),
              Text(
                defaultAddress.phone,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_history, color: Colors.grey, size: 16),
              SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  "${defaultAddress.street}, ${defaultAddress.city}, ${defaultAddress.state} - ${defaultAddress.postalCode}",
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
