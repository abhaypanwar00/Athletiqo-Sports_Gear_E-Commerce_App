import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AppCheckboxTheme {
  AppCheckboxTheme._();

  static CheckboxThemeData checkboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: AppColors.lightGrey, width: 2),
    checkColor: WidgetStateProperty.resolveWith((states) {
      return AppColors.black;
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lime;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
