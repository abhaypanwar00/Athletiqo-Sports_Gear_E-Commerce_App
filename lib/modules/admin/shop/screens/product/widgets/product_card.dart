import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:athletiqo/utils/constants/sizes.dart';

class AdminProductCard extends StatelessWidget {
  final ProductModel product;

  const AdminProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final firstVariation = product.productVariations.first;

    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Card(
        color: AppColors.darkGrey,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(bottom: AppSizes.md),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 100,
                  width: 100,
                  color: AppColors.lightGrey,
                  child: Image.network(
                    firstVariation.images.first,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.sm),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      product.productName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),

                    // Price and
                    Text(
                      "₹${firstVariation.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: AppSizes.md,
                      ),
                    ),
                    Spacer(),

                    // Color Indicators
                    Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 4,
                          children: [
                            ...product.productVariations
                                .take(4)
                                .map(
                                  (v) => Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: AppHelperFunctions.getColor(
                                        v.colorName,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                        Spacer(),
                        Wrap(
                          spacing: 6,
                          runSpacing: -8,
                          children: [
                            ...product.productVariations
                                .expand(
                                  (v) => v.sizesAndStock.map((s) => s.size),
                                )
                                .toSet()
                                .take(5)
                                .map(
                                  (size) => Chip(
                                    label: Text(size),
                                    backgroundColor: AppColors.lightGrey,
                                    labelStyle: const TextStyle(
                                      color: AppColors.black,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                  ),
                                ),
                            if (product.productVariations
                                    .expand(
                                      (v) => v.sizesAndStock.map((s) => s.size),
                                    )
                                    .toSet()
                                    .length >
                                5)
                              Text(
                                "+more sizes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
