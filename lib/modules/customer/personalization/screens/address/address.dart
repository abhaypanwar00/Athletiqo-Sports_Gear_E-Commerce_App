import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/address_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'add_new_address.dart';
import 'widgets/single_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: Appbar(title: "My Addresses", showBackArrow: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.lime,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: AppColors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.addresses.isEmpty) {
          return const Center(child: Text("No addresses found."));
        }

        return ListView.builder(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          itemCount: controller.addresses.length,
          itemBuilder: (_, index) {
            final address = controller.addresses[index];
            return GestureDetector(
              onTap: () => controller.setDefaultAddress(address.id),
              child: SingleAddress(
                address: address,
                selectedAddress: address.isDefault,
              ),
            );
          },
        );
      }),
    );
  }
}
