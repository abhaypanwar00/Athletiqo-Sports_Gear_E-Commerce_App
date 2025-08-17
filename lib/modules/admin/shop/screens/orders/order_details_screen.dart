import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
// import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/admin_actions.dart';
import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/info_tile.dart';
import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/order_detail_card.dart';
import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/ordered_item_card.dart';
import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/price_breakdown_card.dart';
import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Order Details', showBackArrow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Order Summary
            OrderDetailCard(
              cardTitle: 'Order Summary',
              children: [
                InfoTile(label: 'Order ID', value: "#ORD001"),
                InfoTile(
                  label: 'Order Date',
                  value: DateFormat('dd MMMM yyyy').format(order.orderDate),
                ),
                InfoTile(label: 'Order Time', value: '02:15 PM'),
                InfoTile(label: 'Order Status', value: order.status),
                InfoTile(label: 'Payment Status', value: 'Cash on Delivery'),
              ],
            ),

            // Customer Information
            OrderDetailCard(
              cardTitle: 'Customer Information',
              children: [
                InfoTile(label: 'Name', value: order.address.name),
                InfoTile(label: 'Phone Number', value: order.address.phone),
                InfoTile(
                  label: 'Shipping Address',
                  value:
                      "${order.address.street}, ${order.address.city}, ${order.address.state} - ${order.address.postalCode}",
                ),
              ],
            ),

            // Order Item
            OrderedItemsCard(order: order),

            // Price Breakdown
            PriceBreakdownCard(order: order),

            // Admin Actions
            // AdminActions(),

            // AdminActions(
            //   orderId: order.id,
            //   userId: order.userId,
            //   initialStatus: order.status,
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
