import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrderStatusData {
  final String status;
  final int count;
  final Color color;

  OrderStatusData(this.status, this.count, this.color);
}

class OrderStatusPieChart extends StatelessWidget {
  final List<OrderStatusData> data = [
    OrderStatusData("Shipped", 40, Colors.green),
    OrderStatusData("Delivered", 60, Colors.blue),
    OrderStatusData("Pending", 20, Colors.yellow),
    OrderStatusData("Processing", 30, Colors.orange),
  ];

  OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SfCircularChart(
          title: ChartTitle(
            text: 'Order Status Overview',
            textStyle: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontSize: 16),
          ),
          backgroundColor: AppColors.darkGrey,
          legend: Legend(
            isVisible: true,
            textStyle: const TextStyle(color: Colors.white),
            position: LegendPosition.right,
          ),
          series: <PieSeries<OrderStatusData, String>>[
            PieSeries<OrderStatusData, String>(
              dataSource: data,
              xValueMapper: (OrderStatusData d, _) => d.status,
              yValueMapper: (OrderStatusData d, _) => d.count,
              pointColorMapper: (OrderStatusData d, _) => d.color,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}
