import 'package:athletiqo/common/shared/authentication/controllers/signup/verify_email_controller.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/utils/constants/image_strings.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // Back to Login Screen by signing out
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: Icon(CupertinoIcons.clear),
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
              // Title
              Text(
                AppTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              // Email of user
              Text(
                email ?? 'abhaypanwar@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              // Subtitle
              Text(
                AppTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                height: 55,
                // Continue Button
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: Text('Continue'),
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                height: 55,
                width: double.infinity,
                // Resend email button
                child: OutlinedButton(
                  onPressed: () => controller.sendEmailVerificationLink(),
                  child: Text(AppTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
