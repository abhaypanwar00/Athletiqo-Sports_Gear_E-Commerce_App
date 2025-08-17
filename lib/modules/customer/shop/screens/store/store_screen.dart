import 'package:athletiqo/common/widgets/brand/brand_card.dart';
import 'package:athletiqo/common/widgets/cart/cart_counter_icon.dart';
import 'package:athletiqo/common/widgets/container/search_container.dart';
import 'package:athletiqo/common/widgets/layout/app_grid_layout.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/navigation/tab_bar.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/customer/shop/controllers/product/product_controller.dart';
import 'package:athletiqo/modules/customer/shop/screens/brand/brand_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/cart/cart_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/store/widgets/app_category_tab.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});

  final controller = Get.put(CustomerProductController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: Appbar(
          title: "Store",
          actions: [
            CartCounterIcon(onPressed: () => Get.to(() => CartScreen())),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: AppColors.black,
                expandedHeight: AppSizes.getDynamicSize(400),
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Search Bar
                      SearchContainer(text: "Search in store"),
                      SizedBox(height: AppSizes.spaceBtwSections),
                      // Featured Brands
                      TextHeading(text: "Top Brands"),
                      SizedBox(height: AppSizes.spaceBtwItems),
                      Obx(() {
                        final brands = controller.topBrands;
                        return AppGridLayout(
                          mainAxisExtent: AppSizes.getDynamicSize(80),
                          itemCount: brands.length,
                          itemBuilder: (_, index) {
                            final brand = brands[index];
                            return GestureDetector(
                              onTap:
                                  () => Get.to(
                                    () =>
                                        BrandScreen(brandName: brand.brandName),
                                  ),
                              child: BrandCard(
                                brandName: brand.brandName,
                                productCount: brand.productCount,
                                showBorder: true,
                                brandLogo: brand.brandLogo,
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                // Tab Bar
                bottom: AppTabBar(
                  tabs: [
                    Text("Clothing"),
                    Text("FootWear"),
                    Text("Fitness"),
                    Text("Accessories"),
                  ],
                ),
              ),
            ];
          },
          // Tab Bar Products
          body: TabBarView(
            children: [
              AppCategoryTab(category: 'Clothing'),
              AppCategoryTab(category: 'Footwear'),
              AppCategoryTab(category: 'Fitness'),
              AppCategoryTab(category: 'Accessories'),
            ],
          ),
        ),
      ),
    );
  }
}
