import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  final String day;
  final double sales;
  SalesData(this.day, this.sales);
}

class SalesGraph extends StatelessWidget {
  final List<SalesData> data = [
    SalesData('Mon', 5000),
    SalesData('Tue', 3000),
    SalesData('Wed', 7000),
    SalesData('Thu', 4000),
    SalesData('Fri', 6000),
    SalesData('Sat', 8000),
    SalesData('Sun', 2000),
  ];

  SalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Weekly Sales Overview',
            textStyle: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontSize: 16),
          ),
          backgroundColor: AppColors.darkGrey,
          plotAreaBorderWidth: 0,

          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(color: AppColors.darkGrey, width: 1),
            majorTickLines: const MajorTickLines(
              color: AppColors.darkGrey,
              width: 1,
            ),
            labelStyle: const TextStyle(color: AppColors.lightGrey),
          ),

          primaryYAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(color: AppColors.darkGrey, width: 1),
            majorTickLines: const MajorTickLines(
              color: AppColors.darkGrey,
              width: 1,
            ),
            labelStyle: const TextStyle(color: AppColors.lightGrey),
          ),

          series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
              dataSource: data,
              xValueMapper: (SalesData sales, _) => sales.day,
              yValueMapper: (SalesData sales, _) => sales.sales,
              markerSettings: const MarkerSettings(isVisible: true),
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              color: AppColors.lime,
            ),
          ],
        ),
      ),
    );
  }
}
