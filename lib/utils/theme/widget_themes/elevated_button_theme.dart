import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.lime,
      disabledBackgroundColor: AppColors.lightGrey,
      disabledForegroundColor: AppColors.darkGrey,
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.buttonHeight,
        horizontal: AppSizes.buttonWidth,
      ),
      textStyle: TextStyle(
        fontSize: AppSizes.fontSizeMd,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
