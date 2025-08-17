import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDeviceUtils.getScreenWidth(context),
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.lightGrey),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.lightGrey),
            ),
          ],
        ),
      ),
    );
  }
}
