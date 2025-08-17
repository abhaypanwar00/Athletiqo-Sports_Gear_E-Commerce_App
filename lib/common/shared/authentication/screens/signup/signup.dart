import 'package:athletiqo/common/shared/authentication/screens/signup/widgets/signup_form.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(showBackArrow: true, title: AppTexts.signupTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Sign Up Title
              // Text(
              //   AppTexts.signupTitle,
              //   style: Theme.of(context).textTheme.headlineMedium,
              // ),
              // SizedBox(height: AppSizes.spaceBtwSections),
              // Form
              SignupForm(),
              SizedBox(height: AppSizes.spaceBtwSections),
              // Divider
              // FormDivider(text: 'OR'),
              // SizedBox(height: AppSizes.spaceBtwSections),
              // Footer or Google Button
              // GoogleButton(text: "Sign up with Google"),
            ],
          ),
        ),
      ),
    );
  }
}
