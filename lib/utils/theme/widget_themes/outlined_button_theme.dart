import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AppOutlinedButtonTheme {
  AppOutlinedButtonTheme._();

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.lime,
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: AppColors.lime),
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.buttonHeight,
        horizontal: AppSizes.buttonWidth,
      ),
      textStyle: TextStyle(
        fontSize: AppSizes.getDynamicSize(16),
        fontWeight: FontWeight.w700,
        color: AppColors.lime,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
