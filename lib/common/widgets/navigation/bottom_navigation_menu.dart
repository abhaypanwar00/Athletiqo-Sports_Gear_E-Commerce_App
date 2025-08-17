import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';

class BottomNavigationMenu extends StatelessWidget {
  final List<Widget> screens;
  final List<IconData> icons;
  final List<String> labels;

  BottomNavigationMenu({
    super.key,
    required this.screens,
    required this.icons,
    required this.labels,
  }) : assert(
         screens.length == icons.length && icons.length == labels.length,
         "Screens, icons, and labels must have the same length",
       );

  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          height: AppSizes.getDynamicSize(90),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.getDynamicSize(10),
          ),
          decoration: BoxDecoration(color: AppColors.black),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              icons.length,
              (index) => GestureDetector(
                onTap: () => selectedIndex.value = index,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.getDynamicSize(16),
                    vertical: AppSizes.getDynamicSize(8),
                  ),
                  decoration: BoxDecoration(
                    color:
                        selectedIndex.value == index
                            ? AppColors.lime.withOpacity(0.2)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      AppSizes.getDynamicSize(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icons[index],
                        size: AppSizes.getDynamicSize(26),
                        color:
                            selectedIndex.value == index
                                ? AppColors.lime
                                : AppColors.lightGrey,
                      ),
                      if (selectedIndex.value == index)
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppSizes.getDynamicSize(8),
                          ),
                          child: Text(
                            labels[index],
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge!.copyWith(
                              color: AppColors.lime,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
