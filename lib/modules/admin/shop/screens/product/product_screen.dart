import 'package:athletiqo/common/widgets/container/search_container.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/navigation/tab_bar.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/add_product_screen.dart';
import 'package:athletiqo/modules/admin/shop/screens/product/widgets/product_list_view.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: Appbar(
          title: 'Products',
          actions: [
            // Add Product Icon
            IconButton(
              onPressed: () => Get.to(() => AddProductScreen()),
              icon: Icon(
                Iconsax.add,
                color: Colors.white,
                size: AppSizes.iconLg,
              ),
            ),
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
                expandedHeight: AppSizes.getDynamicSize(130),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(
                      top: AppSizes.sm,
                      bottom: AppSizes.defaultSpace,
                      left: AppSizes.defaultSpace,
                      right: AppSizes.defaultSpace,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SearchContainer(text: 'Search'),
                    ),
                  ),
                ),
                // TabBar
                bottom: AppTabBar(
                  tabs: [
                    Text("Clothing"),
                    Text("Fitness"),
                    Text("Footwear"),
                    Text("Accessories"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ProductListView(category: 'Clothing'),
              ProductListView(category: 'Fitness'),
              ProductListView(category: 'Footwear'),
              ProductListView(category: 'Accessories'),
            ],
          ),
        ),
      ),
    );
  }
}
