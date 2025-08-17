import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AppBottomSheetTheme {
  AppBottomSheetTheme._();

  static final BottomSheetThemeData bottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AppColors.white,
    modalBackgroundColor: AppColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
