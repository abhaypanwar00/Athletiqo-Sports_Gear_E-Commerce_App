import 'package:athletiqo/common/widgets/brand/brand_showcase.dart';
import 'package:athletiqo/common/widgets/layout/dynamic_grid_layout.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/customer/shop/controllers/product/product_controller.dart';
import 'package:athletiqo/modules/customer/shop/screens/brand/brand_showcase_screen.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCategoryTab extends StatelessWidget {
  const AppCategoryTab({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerProductController>();
    final brand = controller.getTopBrandWithLogoForCategory(category);
    final images =
        brand != null
            ? controller.getTopBrandImagesForCategory(category, brand.brandName)
            : [];
    final products = controller.getProductsByCategory(category);
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brands
              BrandShowcase(
                onTap:
                    () => Get.to(
                      () => BrandShowcaseScreen(
                        brandName: brand.brandName,
                        categoryName: category,
                      ),
                    ),
                brandName: brand!.brandName,
                productCount: brand.productCount,
                brandLogo: brand.brandLogo,
                images: images,
              ),
              // Products
              TextHeading(text: 'You might aslo like'),
              SizedBox(height: AppSizes.spaceBtwItems),
              DynamicGridLayout(products: products),
            ],
          ),
        ),
      ],
    );
  }
}
