import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/admin/shop/screens/dashboard/widgets/dashboard_cards.dart';
import 'package:athletiqo/modules/admin/shop/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:athletiqo/modules/admin/shop/screens/dashboard/widgets/sales_graph.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "Dashboard"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardCards(), // Top 6 stats
            SizedBox(height: AppSizes.spaceBtwSections),
            SalesGraph(), // Weekly Sales
            SizedBox(height: AppSizes.spaceBtwSections),
            OrderStatusPieChart(), // Pie Chart
          ],
        ),
      ),
    );
  }
}
