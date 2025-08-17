import 'dart:developer';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AdminActions extends StatelessWidget {
  AdminActions({super.key});

  final List<String> orderStatuses = ['Packed', 'Shipped', 'Delivered'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order Status Chips
        Text(
          'Update Order Status',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(orderStatuses.length, (index) {
            // final isSelected = controller.selectedStatus.value == status;
            return ChoiceChip(
              label: Text(orderStatuses[index]),
              selected: false,
              onSelected: (selected) {
                log('Selected: ${orderStatuses[index]}');
              },
              selectedColor: Colors.white,
              backgroundColor: AppColors.darkGrey,
            );
          }),
        ),
        SizedBox(height: 16),

        // Non-working buttons
        // Text(
        //   'Admin Actions',
        //   style: Theme.of(
        //     context,
        //   ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        // ),
        // SizedBox(height: 8),
        // Row(
        //   children: [
        //     Expanded(
        //       child: OutlinedButton(
        //         onPressed: () {},
        //         style: OutlinedButton.styleFrom(
        //           fixedSize: Size(double.infinity, 55),
        //         ),
        //         child: Text('Cancel Order'),
        //       ),
        //     ),
        //     SizedBox(width: AppSizes.defaultSpace),
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {},
        //         style: ElevatedButton.styleFrom(
        //           fixedSize: Size(double.infinity, 55),
        //         ),
        //         child: Text('Contact Customer'),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
