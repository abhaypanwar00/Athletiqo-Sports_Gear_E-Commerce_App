import 'package:athletiqo/common/widgets/container/rounded_container.dart';
import 'package:athletiqo/common/widgets/images/circular_image.dart';
import 'package:athletiqo/common/widgets/text/brand_title_with_verified_icon.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/enums.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brandName,
    required this.productCount,
    required this.brandLogo,
  });

  final bool showBorder;
  final void Function()? onTap;
  final String brandName;
  final int productCount;
  final String brandLogo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: EdgeInsets.all(AppSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CircularImage(
                isNetworkImage: true,
                fit: BoxFit.contain,
                image: brandLogo,
                backgroundColor: Colors.transparent,
                overlayColor: AppColors.white,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BrandTitileWithVerifiedIcon(
                    title: brandName,
                    brandTextSize: TextSizes.small,
                  ),
                  Text(
                    productCount.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
