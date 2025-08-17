import 'package:athletiqo/common/widgets/brand/brand_card.dart';
import 'package:athletiqo/common/widgets/container/rounded_container.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key,
    required this.images,
    required this.brandName,
    required this.productCount,
    required this.brandLogo,
    required this.onTap,
  });

  final List<dynamic> images;
  final String brandName;
  final int productCount;
  final String brandLogo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        showBorder: true,
        borderColor: AppColors.lightGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(AppSizes.md),
        margin: EdgeInsets.only(bottom: AppSizes.spaceBtwSections),
        child: Column(
          children: [
            // Brand with Product Count
            BrandCard(
              showBorder: false,
              brandName: brandName,
              productCount: productCount,
              brandLogo: brandLogo,
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            // Brand Top 3 Product Images
            Row(
              children:
                  images
                      .map(
                        (image) => brandTopProductImageWidget(image, context),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, BuildContext context) {
    return Expanded(
      child: RoundedContainer(
        height: AppSizes.getDynamicSize(100),
        backgroundColor: AppColors.darkGrey,
        margin: EdgeInsets.only(right: AppSizes.md),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
          child: Center(
            child: Image.network(
              image,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
