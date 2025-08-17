import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PriceBreakdownCard extends StatelessWidget {
  const PriceBreakdownCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subtotal = order.totalAmount - 50 - 37;
    return Card(
      color: AppColors.darkGrey,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Breakdown',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _priceRow(context, 'Subtotal', '₹$subtotal'),
            const SizedBox(height: 8),
            _priceRow(context, 'Tax', '₹37.00'),
            const SizedBox(height: 8),
            _priceRow(context, 'Shipping Fee', '₹50.00'),
            const SizedBox(height: 8),
            const Divider(height: 24, thickness: 1, color: AppColors.lightGrey),
            _priceRow(context, 'Total Amount', '₹${order.totalAmount}', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    final style = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
      color: valueColor ?? AppColors.white,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }
}
