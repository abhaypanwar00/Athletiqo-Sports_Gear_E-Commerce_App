import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({
    super.key,
    required this.children,
    required this.cardTitle,
  });

  final String cardTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkGrey,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16),
            Column(children: children),
          ],
        ),
      ),
    );
  }
}
