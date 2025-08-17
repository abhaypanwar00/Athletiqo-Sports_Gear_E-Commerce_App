import 'package:athletiqo/common/shared/authentication/common/success_screen.dart';
import 'package:athletiqo/common/widgets/cart/cart_item_card.dart';
import 'package:athletiqo/common/widgets/container/rounded_container.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/navigation/customer_bottom_navigation_menu.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/address_controller.dart';
import 'package:athletiqo/modules/customer/shop/controllers/cart/cart_controller.dart';
import 'package:athletiqo/modules/customer/shop/controllers/order/order_controller.dart';
import 'package:athletiqo/modules/customer/shop/screens/checkout/widgets/billing_address.dart';
import 'package:athletiqo/modules/customer/shop/screens/checkout/widgets/billing_amount.dart';
import 'package:athletiqo/modules/customer/shop/screens/checkout/widgets/billing_payment_method.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final orderController = Get.put(OrderController());
    final addressController = Get.put(AddressController());
    final defaultAddress = addressController.addresses.firstWhereOrNull(
      (addr) => addr.isDefault,
    );

    return Scaffold(
      appBar: Appbar(title: "Order Review", showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Items in Cart
              Obx(
                () => ListView.separated(
                  itemCount: cartController.cartItems.length,
                  shrinkWrap: true,
                  separatorBuilder:
                      (_, __) => SizedBox(height: AppSizes.spaceBtwSections),
                  itemBuilder: (_, index) {
                    final cartItem = cartController.cartItems[index];
                    return CartItemCard(cartItem: cartItem);
                  },
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Billing Section
              RoundedContainer(
                showBorder: true,
                backgroundColor: AppColors.black,
                padding: EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: [
                    // Pricing
                    Obx(
                      () => BillingAmount(
                        subtotal: cartController.totalPrice.value,
                        shippingFee: 50,
                        taxFee: 37,
                      ),
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    // Divider
                    Divider(),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    // Payment Methods
                    BillingPaymentMethod(),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    // Address
                    BillingAddress(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        // Checkout Button
        child: ElevatedButton(
          onPressed: () async {
            await orderController.placeOrder(
              defaultAddress ?? addressController.addresses.first,
            );

            Get.to(
              () => SuccessScreen(
                image: 'assets/animations/120978-payment-successful.json',
                title: "Success",
                subtitle: "Your item will be shipped soon",
                onPressed:
                    () => Get.offAll(() => CustomerBottomNavigationMenu()),
              ),
            );
          },
          child: Obx(
            () => Text(
              "Checkout  ₹${(cartController.totalPrice.value + 50 + 37).toStringAsFixed(2)}",
            ),
          ),
        ),
      ),
    );
  }
}
