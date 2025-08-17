import 'package:flutter/material.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';

class StockInputs extends StatelessWidget {
  const StockInputs({
    super.key,
    required this.color,
    required this.details,
    required this.controller,
  });

  final Color color;
  final Map<String, dynamic> details;
  final AddProductController controller;

  @override
  Widget build(BuildContext context) {
    final selectedSizes = List<Map<String, String>>.from(details['sizes']);
    final sameStockForAll = controller.sameStockForAllMap[color] ?? false;
    // final sharedStock = controller.sharedStockMap[color] ?? '';

    if (selectedSizes.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextHeading(text: "Stocks"),
        SizedBox(height: AppSizes.sm),

        sameStockForAll
            ? Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        initialValue: controller.sharedStockMap[color] ?? '',
                        onChanged:
                            (value) =>
                                controller.updateSharedStock(color, value),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "All",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ],
            )
            : Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  selectedSizes.map((entry) {
                    final size = entry['size']!;
                    final stock = entry['stock'] ?? '';

                    return SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            initialValue: stock,
                            onChanged:
                                (value) =>
                                    controller.updateStock(color, size, value),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            size,
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),

        SizedBox(height: AppSizes.sm),
        Row(
          children: [
            Checkbox(
              value: sameStockForAll,
              onChanged:
                  (val) =>
                      controller.toggleSameStockForAll(color, val ?? false),
            ),
            const Text("Same stock for all sizes"),
          ],
        ),
      ],
    );
  }
}
