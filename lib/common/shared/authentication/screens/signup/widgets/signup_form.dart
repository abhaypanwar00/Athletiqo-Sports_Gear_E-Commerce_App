import 'package:athletiqo/common/shared/authentication/controllers/signup/signup_controller.dart';
import 'package:athletiqo/common/shared/authentication/screens/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // First Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHeading(text: 'First Name'),
                    SizedBox(height: AppSizes.xs),
                    TextFormField(
                      controller: controller.firstName,
                      validator:
                          (value) => AppValidator.validateEmptyText(
                            "First name",
                            value,
                          ),
                      expands: false,
                      decoration: InputDecoration(
                        hintText: 'First name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSizes.spaceBtwInputFields),

              // Last Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHeading(text: 'Last Name'),
                    SizedBox(height: AppSizes.xs),
                    TextFormField(
                      controller: controller.lastName,
                      validator:
                          (value) => AppValidator.validateEmptyText(
                            "Last name",
                            value,
                          ),
                      expands: false,
                      decoration: InputDecoration(
                        hintText: 'Last name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),

          // Username
          TextHeading(text: 'Username'),
          SizedBox(height: AppSizes.xs),
          TextFormField(
            controller: controller.username,
            validator:
                (value) => AppValidator.validateEmptyText("Username", value),
            decoration: InputDecoration(
              hintText: 'Pick your arena handle',
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),

          // Email
          TextHeading(text: 'Email'),
          SizedBox(height: AppSizes.xs),
          TextFormField(
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
            decoration: InputDecoration(
              hintText: "What's your email?",
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),

          // Phone Number
          TextHeading(text: 'Mobile Number'),
          SizedBox(height: AppSizes.xs),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => AppValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              hintText: 'Digits for order alerts',
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),

          // Password
          TextHeading(text: 'Password'),
          SizedBox(height: AppSizes.xs),
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => AppValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                hintText: 'Only legends remember this one',
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwSections),
          // Terms and Condition Checkbox
          TermsAndConditionCheckbox(),
          SizedBox(height: AppSizes.spaceBtwSections),
          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(double.infinity, 55),
              ),
              child: Text(AppTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
