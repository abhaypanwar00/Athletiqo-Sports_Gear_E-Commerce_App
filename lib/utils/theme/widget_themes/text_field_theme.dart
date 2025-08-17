import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.lightGrey,
    suffixIconColor: AppColors.lightGrey,
    labelStyle: TextStyle(color: AppColors.white, fontSize: 14),
    hintStyle: TextStyle(
      color: AppColors.lightGrey,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    errorStyle: TextStyle(color: AppColors.error, fontSize: 14),
    filled: true,
    fillColor: AppColors.darkGrey,

    // Transparent Borders
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.inputFieldRadius),
      ),
      borderSide: BorderSide(width: 1, color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.inputFieldRadius),
      ),
      borderSide: BorderSide(width: 1, color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.inputFieldRadius),
      ),
      borderSide: BorderSide(width: 1, color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.inputFieldRadius),
      ),
      borderSide: BorderSide(width: 1, color: Colors.transparent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.inputFieldRadius),
      ),
      borderSide: BorderSide(width: 2, color: Colors.transparent),
    ),
  );
}
