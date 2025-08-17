import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class OrderedItemTile extends StatelessWidget {
  const OrderedItemTile({
    super.key,
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    required this.color,
    required this.size,
  });

  final String image;
  final String name;
  final int quantity;
  final double price;
  final String color;
  final String size;

  @override
  Widget build(BuildContext context) {
    final subtotal = quantity * price;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Product Quantity
                Text(
                  '$quantity × ₹${price.toStringAsFixed(2)}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.lightGrey),
                ),
                const SizedBox(height: 2),
                // Product Color and Size
                Text(
                  'Color: $color | Size: $size',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.lightGrey),
                ),
              ],
            ),
          ),

          // Subtotal
          Text(
            '₹${subtotal.toStringAsFixed(2)}',
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
