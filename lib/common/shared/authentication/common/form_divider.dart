import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: AppColors.lightGrey,
            thickness: 0.8,
            indent: 50,
            endIndent: 8,
          ),
        ),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(color: AppColors.lightGrey),
        ),
        Flexible(
          child: Divider(
            color: AppColors.lightGrey,
            thickness: 0.8,
            indent: 8,
            endIndent: 50,
          ),
        ),
      ],
    );
  }
}
