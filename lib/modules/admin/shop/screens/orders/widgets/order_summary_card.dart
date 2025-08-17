import 'package:athletiqo/modules/admin/shop/screens/orders/order_details_screen.dart';
import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.customerName,
    required this.itemsCount,
    required this.paymentMethod,
    required this.status,
    required this.price, required this.order,
  });

  final OrderModel order;

  final String orderId,
      date,
      customerName,
      itemsCount,
      price,
      paymentMethod,
      status;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkGrey,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Order ID
                Text(
                  orderId,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                // Date
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.lightGrey),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Customer name, Item Count and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer Name
                    Text(
                      customerName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // No. of Items
                    Text(
                      '$itemsCount items',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Order Status
                Chip(
                  label: Text(status),
                  backgroundColor: Colors.orange.shade100,
                  labelStyle: const TextStyle(color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Price and Payment Method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Text(
                      '₹ $price',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Payment Method
                    Text(
                      paymentMethod,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ],
                ),
                // View Details Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(130, 50),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed:
                      () => Get.to(() => OrderDetailsScreen(order: order)),
                  child: Text(
                    'View Details',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.apply(color: AppColors.lime),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
