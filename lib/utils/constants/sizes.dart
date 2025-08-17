import 'package:flutter/widgets.dart';

class AppSizes {
  // Padding and margin sizes
  static double get xs => getDynamicSize(4.0);
  static double get sm => getDynamicSize(8.0);
  static double get md => getDynamicSize(16.0);
  static double get lg => getDynamicSize(24.0);
  static double get xl => getDynamicSize(32.0);

  // Icon sizes
  static double get iconXs => getDynamicSize(12.0);
  static double get iconSm => getDynamicSize(16.0);
  static double get iconMd => getDynamicSize(24.0);
  static double get iconLg => getDynamicSize(32.0);

  // Font sizes
  static double get fontSizeSm => getDynamicSize(14.0);
  static double get fontSizeMd => getDynamicSize(16.0);
  static double get fontSizeLg => getDynamicSize(18.0);

  // Button sizes
  static double get buttonHeight => getDynamicSize(18.0);
  static double get buttonRadius => getDynamicSize(12.0);
  static double get buttonWidth => getDynamicSize(12.0);
  static double get buttonElevation => getDynamicSize(4.0);

  // AppBar height
  static double get appBarHeight => getDynamicSize(56.0);

  // Image sizes
  static double get imageThumbSize => getDynamicSize(80.0);

  // Default spacing between sections
  static double get defaultSpace => getDynamicSize(24.0);
  static double get spaceBtwItems => getDynamicSize(16.0);
  static double get spaceBtwSections => getDynamicSize(32.0);

  // Border radius
  static double get borderRadiusSm => getDynamicSize(4.0);
  static double get borderRadiusMd => getDynamicSize(8.0);
  static double get borderRadiusLg => getDynamicSize(12.0);

  // Divider height
  static double get dividerHeight => getDynamicSize(1.0);

  // Product item dimensions
  static double get productImageSize => getDynamicSize(120.0);
  static double get productImageRadius => getDynamicSize(16.0);
  static double get productItemHeight => getDynamicSize(160.0);

  // Input field
  static double get inputFieldRadius => getDynamicSize(12.0);
  static double get spaceBtwInputFields => getDynamicSize(16.0);

  // Card sizes
  static double get cardRadiusLg => getDynamicSize(16.0);
  static double get cardRadiusMd => getDynamicSize(12.0);
  static double get cardRadiusSm => getDynamicSize(10.0);
  static double get cardRadiusXs => getDynamicSize(6.0);
  static double get cardElevation => getDynamicSize(2.0);

  // Image carousel height
  static double get imageCarouselHeight => getDynamicSize(200.0);

  // Loading indicator size
  static double get loadingIndicatorSize => getDynamicSize(36.0);

  // Grid view spacing
  static double get gridViewSpacing => getDynamicSize(16.0);

  // Method to scale the sizes based on screen width using MediaQuery
  static double getDynamicSize(double baseSize) {
    final screenWidth = WidgetsBinding.instance.window.physicalSize.width;
    final screenWidthInDp =
        screenWidth / WidgetsBinding.instance.window.devicePixelRatio;
    final baseWidth = 440.0; // Base screen width
    final scaleFactor = screenWidthInDp / baseWidth;

    return baseSize * scaleFactor;
  }
}
