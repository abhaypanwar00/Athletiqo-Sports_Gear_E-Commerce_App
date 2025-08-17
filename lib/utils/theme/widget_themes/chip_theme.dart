import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AppChipTheme {
  AppChipTheme._();

  static ChipThemeData chipTheme = ChipThemeData(
    labelStyle: TextStyle(
      fontSize: AppSizes.getDynamicSize(16),
      fontWeight: FontWeight.w700,
      color: AppColors.lightGrey,
    ),
    selectedColor: AppColors.white,
    pressElevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    showCheckmark: false,
    backgroundColor: AppColors.darkGrey,
    side: BorderSide(color: AppColors.darkGrey),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
