import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/update_name_controller.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';

class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: Appbar(showBackArrow: true, title: "Update Name"),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              "User real name for easy verification. This name will appear on several screens.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Form to update name
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  // First Name
                  TextFormField(
                    controller: controller.firstName,
                    validator:
                        (value) =>
                            AppValidator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: AppTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwInputFields),
                  // Last Name
                  TextFormField(
                    controller: controller.lastName,
                    validator:
                        (value) =>
                            AppValidator.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: AppTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Update button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
