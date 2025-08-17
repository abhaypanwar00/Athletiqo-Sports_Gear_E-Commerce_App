import 'package:athletiqo/common/shared/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: Appbar(title: 'Forget Password', showBackArrow: true),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: AppSizes.spaceBtwSections),
            // Reset Email Field
            TextHeading(text: 'Email'),
            SizedBox(height: AppSizes.xs),
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: AppValidator.validateEmail,
                decoration: InputDecoration(
                  hintText: 'Enter your comeback email',
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwSections),
            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => controller.sendPasswordResetEmail(),
                child: Text(AppTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
