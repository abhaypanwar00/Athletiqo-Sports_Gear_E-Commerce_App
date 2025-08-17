import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BillingAmount extends StatelessWidget {
  const BillingAmount({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.taxFee,
  });

  final double subtotal, shippingFee, taxFee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "₹${(subtotal).toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping Fee", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "₹${(shippingFee).toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax Fee", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "₹${(taxFee).toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order Total", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "₹${(subtotal + shippingFee + taxFee).toStringAsFixed(2)}",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
