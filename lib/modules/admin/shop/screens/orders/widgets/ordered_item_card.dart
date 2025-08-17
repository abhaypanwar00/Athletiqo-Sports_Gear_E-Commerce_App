import 'package:athletiqo/modules/admin/shop/screens/orders/widgets/order_item_tile.dart';
import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class OrderedItemsCard extends StatelessWidget {
  const OrderedItemsCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
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
              'Ordered Items',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return OrderedItemTile(
                  image: item.thumbnail,
                  name: item.title,
                  quantity: item.quantity,
                  price: item.price,
                  color: item.selectedColor,
                  size: item.selectedSize,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
