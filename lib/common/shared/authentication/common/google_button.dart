import 'package:athletiqo/common/shared/authentication/controllers/login/login_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      // Google Sign In Button
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async => controller.googleSignIn(),
            icon: Image(
              width: AppSizes.lg,
              height: AppSizes.lg,
              image: AssetImage('assets/brands/google-logo.png'),
            ),
          ),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
