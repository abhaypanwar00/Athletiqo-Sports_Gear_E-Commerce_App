import 'package:athletiqo/common/widgets/cart/cart_item_card.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/repository/cart_repository.dart';
import 'package:athletiqo/modules/customer/shop/screens/checkout/checkout.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athletiqo/modules/customer/shop/controllers/cart/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    Get.put(CartRepository());
    controller.loadCart();

    return Scaffold(
      appBar: Appbar(title: "Cart", showBackArrow: true),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Obx(() {
          if (controller.cartItems.isEmpty) {
            return Center(child: Text("Your cart is empty"));
          }

          return ListView.separated(
            itemCount: controller.cartItems.length,
            shrinkWrap: true,
            separatorBuilder:
                (_, __) => SizedBox(height: AppSizes.spaceBtwSections),
            itemBuilder: (_, index) {
              final cartItem = controller.cartItems[index];
              return CartItemCard(cartItem: cartItem);
            },
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Obx(() {
          return ElevatedButton(
            onPressed: () => Get.to(() => CheckoutScreen()),
            child: Text(
              "Checkout  ₹${controller.totalPrice.value.toStringAsFixed(2)}",
            ),
          );
        }),
      ),
    );
  }
}
