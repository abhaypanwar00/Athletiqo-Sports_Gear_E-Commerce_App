import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: AppColors.lime,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.lightGrey,
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        dividerColor: Colors.transparent,
        padding: EdgeInsets.all(10),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());
}
