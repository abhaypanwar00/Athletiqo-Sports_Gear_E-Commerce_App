import 'package:athletiqo/common/widgets/text/brand_title_text.dart';
import 'package:athletiqo/utils/constants/enums.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BrandTitileWithVerifiedIcon extends StatelessWidget {
  const BrandTitileWithVerifiedIcon({
    super.key,
    required this.title,
    this.textColor,
    this.maxLines = 1,
    this.iconColor = Colors.blue,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BrandTitleText(
          title: title,
          maxLines: maxLines,
          color: textColor,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        ),
        SizedBox(width: AppSizes.xs),
        Icon(Iconsax.verify5, color: Colors.blue, size: AppSizes.iconSm),
      ],
    );
  }
}
