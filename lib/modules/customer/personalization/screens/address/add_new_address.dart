import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/add_address_controller.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddAddressController());
    return Scaffold(
      appBar: Appbar(title: "Add new Address", showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: addressController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeading(text: "Name"),
                SizedBox(height: AppSizes.xs),
                TextFormField(
                  controller: addressController.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    hintText: 'Your Name',
                  ),
                  validator:
                      (value) => AppValidator.validateEmptyText('Name', value),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields),
                TextHeading(text: "Phone Number"),
                SizedBox(height: AppSizes.xs),
                TextFormField(
                  controller: addressController.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    hintText: "Phone Number",
                  ),
                  validator:
                      (value) =>
                          AppValidator.validateEmptyText('Phone Number', value),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields),
                TextHeading(text: "Street"),
                SizedBox(height: AppSizes.xs),
                TextFormField(
                  controller: addressController.street,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    hintText: "Street Name",
                  ),
                  validator:
                      (value) =>
                          AppValidator.validateEmptyText('Street name', value),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields),
                TextHeading(text: "Postal Code"),
                SizedBox(height: AppSizes.xs),
                TextFormField(
                  controller: addressController.postalCode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.code),
                    hintText: "Postal Code",
                  ),
                  validator:
                      (value) =>
                          AppValidator.validateEmptyText('Postal Code', value),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeading(text: "City"),
                          SizedBox(height: AppSizes.xs),
                          TextFormField(
                            controller: addressController.city,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              hintText: "City",
                            ),
                            validator:
                                (value) => AppValidator.validateEmptyText(
                                  'City name',
                                  value,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSizes.spaceBtwInputFields),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeading(text: "State"),
                          SizedBox(height: AppSizes.xs),
                          TextFormField(
                            controller: addressController.state,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              hintText: "State",
                            ),
                            validator:
                                (value) => AppValidator.validateEmptyText(
                                  'State name',
                                  value,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => addressController.saveAddress(),
                    child: Text("save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
