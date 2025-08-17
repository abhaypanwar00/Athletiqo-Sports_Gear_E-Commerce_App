import 'package:athletiqo/common/widgets/cart/product_add_remove_button.dart';
import 'package:athletiqo/common/widgets/images/rounded_image_container.dart';
import 'package:athletiqo/common/widgets/text/product_title_text.dart';
import 'package:athletiqo/modules/customer/shop/controllers/cart/cart_controller.dart';
import 'package:athletiqo/modules/customer/shop/models/cart_item_model.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.20,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: GestureDetector(
                onTap: () => controller.removeFromCart(cartItem),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Iconsax.shop_remove, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedImageContainer(
            isNetworkImage: true,
            imageUrl: cartItem.thumbnail,
            width: 60,
            height: 60,
            padding: EdgeInsets.all(AppSizes.xs),
            backgroundColor: Colors.white,
            fit: BoxFit.contain,
            borderRadius: 10,
          ),
          SizedBox(width: AppSizes.spaceBtwItems),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Product Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product name
                    SizedBox(
                      width: 180,
                      child: ProductTitleText(
                        title: cartItem.title,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        // color
                        Text(
                          "Color: ${cartItem.selectedColor}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 10),
                        // size
                        Text(
                          "Size: ${cartItem.selectedSize}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "₹${cartItem.price}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                /// Quantity Controls
                AddOrRemoveProductButton(
                  quantity: cartItem.quantity,
                  onAdd: () {
                    final updatedItem = cartItem.copyWith(
                      quantity: cartItem.quantity + 1,
                    );
                    controller.updateCartItem(cartItem, updatedItem);
                  },
                  onRemove: () {
                    if (cartItem.quantity > 1) {
                      final updatedItem = cartItem.copyWith(
                        quantity: cartItem.quantity - 1,
                      );
                      controller.updateCartItem(cartItem, updatedItem);
                    } else {
                      controller.removeFromCart(cartItem);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
