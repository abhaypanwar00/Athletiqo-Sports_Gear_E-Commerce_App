import 'package:athletiqo/common/shared/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:athletiqo/common/shared/authentication/screens/login/login.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/image_strings.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(CupertinoIcons.clear, color: AppColors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                width: AppHelperFunctions.screenWidth() * 0.6,
                image: AssetImage(AppImages.deliveredEmailIllustration),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              // Email
              Text(
                email,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              // Title and Subtitle
              Text(
                AppTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                height: 55,
                // Done Button
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => LoginScreen()),
                  child: Text(AppTexts.done),
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                // Resend email button
                child: TextButton(
                  onPressed:
                      () => ForgetPasswordController.instance
                          .resendPasswordResetEmail(email),
                  child: Text(
                    AppTexts.resendEmail,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
