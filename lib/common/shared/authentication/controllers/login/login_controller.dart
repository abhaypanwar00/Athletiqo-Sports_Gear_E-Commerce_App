import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/user_controller.dart';
import 'package:athletiqo/utils/helpers/network_manager.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variables
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  // Login with email and password
  void loginWithEmailAndPassword() async {
    try {
      // Start loading
      isLoading.value = true;

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loading
        isLoading.value = false;
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        // stop loading
        isLoading.value = false;
        return;
      }

      // Login user with email and password
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Stop Loading
      isLoading.value = false;

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Show generic error to user
      // stop loading
      isLoading.value = false;
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Login with google account
  Future<void> googleSignIn() async {
    try {
      // Start loading
      isLoading.value = true;

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loading
        isLoading.value = false;
        return;
      }

      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save user record
      await userController.saveUserRecord(userCredentials);

      // Stop Loading
      isLoading.value = false;

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // stop loading
      isLoading.value = false;
      AppLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
