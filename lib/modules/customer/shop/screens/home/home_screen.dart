import 'package:athletiqo/modules/customer/shop/controllers/product/product_controller.dart';
import 'package:get/get.dart';
import 'package:athletiqo/modules/customer/shop/screens/home/widgets/home_app_bar.dart';
import 'package:athletiqo/common/widgets/container/search_container.dart';
import 'package:athletiqo/common/widgets/layout/dynamic_grid_layout.dart';
import 'package:athletiqo/common/widgets/navigation/tab_bar.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerProductController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: HomeAppBar(),
        body: NestedScrollView(
          headerSliverBuilder:
              (_, innerBoxIsScrolled) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: AppColors.black,
                  expandedHeight: AppSizes.getDynamicSize(150),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.all(AppSizes.defaultSpace),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SearchContainer(text: 'Search'),
                      ),
                    ),
                  ),
                  bottom: AppTabBar(
                    tabs: [Text("All"), Text("Men"), Text("Women")],
                  ),
                ),
              ],
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.lime),
              );
            }

            return TabBarView(
              children:
                  ['All', 'Men', 'Women'].map((gender) {
                    final products = controller.getProductsByGender(gender);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: AppSizes.defaultSpace,
                              left: AppSizes.defaultSpace,
                              bottom: AppSizes.getDynamicSize(70),
                            ),
                            child: DynamicGridLayout(products: products),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
