import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/cart/cart_counter_icon.dart';
import 'package:athletiqo/modules/customer/shop/screens/cart/cart_screen.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());

  @override
  Widget build(BuildContext context) {
    return Appbar(
      isComplexAppBar: true,
      complexAppBar: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar Title
          Text(
            "Good day for shopping",
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: AppColors.lightGrey),
          ),
          // AppBar SubTitle
          Text("Abhay Panwar", style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
      // Cart Button
      actions: [
        CartCounterIcon(onPressed: () => Get.to(() => const CartScreen())),
      ],
    );
  }
}
