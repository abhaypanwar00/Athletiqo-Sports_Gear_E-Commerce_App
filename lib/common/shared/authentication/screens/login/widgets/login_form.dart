import 'package:athletiqo/common/shared/authentication/controllers/login/login_controller.dart';
import 'package:athletiqo/common/shared/authentication/screens/password_config/forget_password.dart';
import 'package:athletiqo/common/shared/authentication/screens/signup/signup.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Field
            TextHeading(text: 'Email'),
            SizedBox(height: AppSizes.sm),
            TextFormField(
              controller: controller.email,
              validator: (value) => AppValidator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                hintText: 'Drop your email',
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwInputFields),
            // Password Field
            TextHeading(text: 'Password'),
            SizedBox(height: AppSizes.sm),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator:
                    (value) =>
                        AppValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  hintText: 'Your access pass',
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
            SizedBox(height: AppSizes.spaceBtwInputFields / 2),
            // Forget Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => ForgetPasswordScreen()),
                child: Text(
                  AppTexts.forgetPassword,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.loginWithEmailAndPassword(),
                child: Obx(
                  () =>
                      controller.isLoading.value
                          ? Text('Signing in...')
                          : Text(AppTexts.signIn),
                ),
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => SignupScreen()),
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(double.infinity, 55),
                ),
                child: Text(AppTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
