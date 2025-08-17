import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.child,
    this.radius,
    this.backgroundColor = AppColors.white,
    this.showBorder = false,
    this.borderColor,
  });

  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundColor;
  final bool showBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? AppSizes.cardRadiusLg),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor ?? AppColors.lightGrey) : null,
      ),
      child: child,
    );
  }
}
