import 'dart:async';
import 'package:athletiqo/common/shared/authentication/common/success_screen.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/utils/constants/image_strings.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerificationLink();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send email verification link
  sendEmailVerificationLink() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerificationLink();
      AppLoaders.successSnackBar(
        title: "Email Sent",
        message: "Please check your inbox and verify your email",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }

  // Set timer for Auto Redirect
  setTimerForAutoRedirect() {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: AppImages.successfullyRegisterAnimation,
              title: AppTexts.yourAccountCreatedTitle,
              subtitle: AppTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  // Manually check if email verified
  checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: AppImages.successfullyRegisterAnimation,
          title: AppTexts.yourAccountCreatedTitle,
          subtitle: AppTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
