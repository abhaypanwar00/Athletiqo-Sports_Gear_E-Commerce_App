import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.text,
    this.buttonTitle = 'View all',
    this.textColor,
    this.showActionButton = false,
    this.onPressed,
  });

  final String text, buttonTitle;
  final Color? textColor;
  final bool showActionButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.lime,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}
