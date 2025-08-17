import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  const TextHeading({
    super.key,
    required this.text,
    this.color,
    this.fontWeight,
    this.fontsize,
  });

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontsize ?? AppSizes.getDynamicSize(16),
        color: color,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
