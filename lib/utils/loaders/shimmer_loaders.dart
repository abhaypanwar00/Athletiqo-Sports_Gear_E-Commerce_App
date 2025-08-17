import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double width, height;
  final Color? color;
  final BoxShape? shape;

  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.color,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.darkGrey,
      highlightColor: AppColors.lightGrey,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColors.darkGrey,
          shape: shape ?? BoxShape.circle,
        ),
      ),
    );
  }
}
