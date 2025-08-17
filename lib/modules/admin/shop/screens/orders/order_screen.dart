import 'package:athletiqo/common/widgets/container/search_container.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/navigation/tab_bar.dart';
import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/order_summary_card.dart';
import 'package:athletiqo/modules/customer/shop/controllers/order/order_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    orderController.fetchAllOrders();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: Appbar(title: "Orders"),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: AppColors.black,
                expandedHeight: AppSizes.getDynamicSize(130),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(
                      top: AppSizes.sm,
                      bottom: AppSizes.defaultSpace,
                      left: AppSizes.defaultSpace,
                      right: AppSizes.defaultSpace,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SearchContainer(text: 'Search'),
                    ),
                  ),
                ),
                // TabBar
                bottom: AppTabBar(
                  tabs: [
                    Text("All"),
                    Text("Pending"),
                    Text("Shipped"),
                    Text("Delivered"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: orderController.allOrders.length,
                itemBuilder: (context, index) {
                  final order = orderController.allOrders[index];
                  return OrderSummaryCard(
                    order: order,
                    orderId: "#ORD",
                    date: DateFormat('dd MMMM yyyy').format(order.orderDate),
                    customerName: order.address.name,
                    itemsCount: order.items.length.toString(),
                    paymentMethod: 'Cash on Delivery',
                    status: order.status,
                    price: order.totalAmount.toString(),
                  );
                },
              ),
              Center(child: Text("Processing")),
              Center(child: Text("Shipped")),
              Center(child: Text("Delivered")),
            ],
          ),
        ),
      ),
    );
  }
}
