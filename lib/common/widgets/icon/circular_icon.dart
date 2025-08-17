import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.width,
    this.height,
    this.size,
    this.iconColor,
    this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? width, height, size;
  final Color? iconColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            backgroundColor != null
                ? backgroundColor!
                : AppColors.black.withOpacity(0.9),

        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor, size: size ?? AppSizes.iconLg),
        ),
      ),
    );
  }
}
