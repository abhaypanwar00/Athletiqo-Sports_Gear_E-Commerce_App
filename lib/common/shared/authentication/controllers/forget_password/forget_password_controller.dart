import 'package:athletiqo/common/shared/authentication/screens/password_config/reset_password.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/utils/helpers/network_manager.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send reset password email [from forget password screen]
  sendPasswordResetEmail() async {
    try {
      // Start loading

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loading
        return;
      }

      // Form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        // stop loading
        return;
      }

      // Send password reset email
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      // Stop Loading

      AppLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link sent to reset your password',
      );

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Show generic error to user
      // stop loading
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  // Resend password reset email
  resendPasswordResetEmail(String email) async {
    try {
      // Start loading

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loading
        return;
      }

      // Send password reset email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Stop Loading

      AppLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link sent to reset your password',
      );
    } catch (e) {
      // Show generic error to user
      // stop loading
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}
