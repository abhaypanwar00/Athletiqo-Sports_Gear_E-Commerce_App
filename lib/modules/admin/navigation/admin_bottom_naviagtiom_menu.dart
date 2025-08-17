import 'package:athletiqo/modules/admin/personlization/settings/admin_settings_screen.dart';
import 'package:athletiqo/common/widgets/navigation/bottom_navigation_menu.dart';
import 'package:athletiqo/modules/admin/shop/screens/orders/order_screen.dart';
import 'package:athletiqo/modules/admin/shop/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminBottomNavigationMenu extends StatelessWidget {
  const AdminBottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationMenu(
      screens: [
        // AdminDashboardScreen(),
        AdminProductScreen(),
        AdminOrderScreen(),
        AdminSettingsScreen(),
      ],
      icons: const [
        // Iconsax.home,
        Iconsax.shopping_bag,
        Iconsax.box,
        Iconsax.setting,
      ],
      labels: ["Products", "Orders", "Settings"],
    );
  }
}
