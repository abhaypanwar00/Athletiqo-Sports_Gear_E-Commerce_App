import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/bottom_sheet_theme.dart';
import 'widget_themes/checkbox_theme.dart';
import 'widget_themes/chip_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.lightGrey,
    brightness: Brightness.light,
    primaryColor: AppColors.lime,
    textTheme: AppTextTheme.textTheme,
    chipTheme: AppChipTheme.chipTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppbarTheme.appBarTheme,
    checkboxTheme: AppCheckboxTheme.checkboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.bottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.outlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.inputDecorationTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkGrey,
      selectedItemColor: AppColors.lime,
      unselectedItemColor: AppColors.lightGrey,
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.lime),
  );
}
