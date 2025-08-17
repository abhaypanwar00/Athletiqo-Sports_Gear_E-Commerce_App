import 'package:athletiqo/common/shared/authentication/screens/signup/verify_email.dart';
import 'package:athletiqo/data/models/user_models.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/data/repository/user/user_repo.dart';
import 'package:athletiqo/utils/helpers/network_manager.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Signup
  void signup() async {
    try {
      // Start loading

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loading
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        // stop loading
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        AppLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account , you must have to read and accept the Privacy Policy and Terms of Use',
        );
        return;
      }

      // Register user in firebase auth and save user data in firebase
      final userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save auth data in firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        username: username.text.trim(),
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        role: 'customer'
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Stop Loading

      // Show success message
      AppLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your account has been created. Verify email to continue.",
      );

      // Move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Show generic error to user
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}
