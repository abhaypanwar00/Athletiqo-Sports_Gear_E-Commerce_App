import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/shop/controllers/order/order_controller.dart';
import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());

    // Fetch orders when screen is opened
    orderController.fetchUserOrders();

    return Scaffold(
      appBar: Appbar(title: "My Orders", showBackArrow: true),
      body: Obx(() {
        if (orderController.userOrders.isEmpty) {
          return const Center(child: Text("No orders found."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orderController.userOrders.length,
          itemBuilder: (context, index) {
            final order = orderController.userOrders[index];
            return OrderCard(order: order);
          },
        );
      }),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(order.orderDate);

    return Card(
      color: AppColors.darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID: ${order.id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Date: $formattedDate"),
            Text("Total: ₹${order.totalAmount.toStringAsFixed(2)}"),
            Text(
              "Status: ${order.status}",
              style: const TextStyle(color: Colors.green),
            ),
            const Divider(height: 20),
            const Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item.thumbnail,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Color: ${item.selectedColor} | Size: ${item.selectedSize}",
                          ),
                          Text(
                            "Qty: ${item.quantity} x ₹${item.price.toStringAsFixed(2)}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
