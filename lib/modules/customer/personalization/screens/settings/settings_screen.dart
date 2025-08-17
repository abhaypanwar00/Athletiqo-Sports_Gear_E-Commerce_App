import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/modules/customer/personalization/screens/address/address.dart';
import 'package:athletiqo/modules/customer/personalization/screens/profile/profile.dart';
import 'package:athletiqo/modules/customer/personalization/screens/settings/widgets/settings_menu_tile.dart';
import 'package:athletiqo/modules/customer/shop/screens/cart/cart_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/order/order_screen.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "Settings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              // Profile
              SettingsMenuTile(
                icon: Iconsax.profile_add,
                title: "My Profile",
                subtitle: "Update profile and details",
                onTap: () => Get.to(() => ProfileScreen()),
              ),

              // Addresses
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Addresses",
                subtitle: "Set shopping delivery address",
                onTap: () => Get.to(() => AddressScreen()),
              ),

              // Cart
              SettingsMenuTile(
                icon: Iconsax.shopping_cart,
                title: "Cart",
                subtitle: "Add and remove prodcuts or move to checkout",
                onTap: () => Get.to(() => CartScreen()),
              ),

              // Orders
              SettingsMenuTile(
                icon: Iconsax.bag_tick,
                title: "My Orders",
                subtitle: "In-progress or completed orders",
                onTap: () => Get.to(() => OrderScreen()),
              ),

              SizedBox(height: AppSizes.spaceBtwSections),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
