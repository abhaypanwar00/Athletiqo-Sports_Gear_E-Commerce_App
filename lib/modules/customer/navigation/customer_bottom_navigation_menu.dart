import 'package:athletiqo/common/widgets/navigation/bottom_navigation_menu.dart';
import 'package:athletiqo/modules/customer/personalization/screens/settings/settings_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/home/home_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/store/store_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomerBottomNavigationMenu extends StatelessWidget {
  const CustomerBottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationMenu(
      screens: [
        HomeScreen(),
        StoreScreen(),
        WishlistScreen(),
        SettingsScreen(),
      ],
      icons: const [Iconsax.home, Iconsax.shop, Iconsax.heart, Iconsax.setting],
      labels: ["Home", "Store", "Wishlist", "Settings"],
    );
  }
}
