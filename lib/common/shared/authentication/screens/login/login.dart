import 'package:athletiqo/common/shared/authentication/screens/login/widgets/login_form.dart';
import 'package:athletiqo/common/shared/authentication/screens/login/widgets/login_header.dart';
import 'package:athletiqo/common/widgets/styles/spacing_styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Header
              LoginHeader(),
              // Form
              LoginForm(),
              // Divider
              // FormDivider(text: 'OR'),
              // SizedBox(height: AppSizes.spaceBtwSections),
              // Google Signin Button
              // GoogleButton(text: "Sign in with Google"),
            ],
          ),
        ),
      ),
    );
  }
}
