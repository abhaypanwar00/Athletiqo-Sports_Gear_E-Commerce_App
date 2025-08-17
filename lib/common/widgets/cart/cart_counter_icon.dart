import 'package:athletiqo/modules/customer/shop/controllers/cart/cart_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor = AppColors.white,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  cartController.cartItems.length.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: AppColors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
