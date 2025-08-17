import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardCards extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'title': 'Total Revenue',
      'value': '\$20,000',
      'icon': Iconsax.money_recive,
    },
    {'title': 'Total Orders', 'value': '320', 'icon': Iconsax.box},
    {'title': 'Latest Orders', 'value': '12', 'icon': Iconsax.book},
    {'title': 'Low Stock', 'value': '5', 'icon': Iconsax.warning_2},
    {'title': 'Customers', 'value': '150', 'icon': Iconsax.people},
    {'title': 'Visitors', 'value': '3,200', 'icon': Iconsax.user_octagon},
  ];

  DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          elevation: 2,
          color: AppColors.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(item['icon'], size: 32, color: AppColors.lime),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      item['value'],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
