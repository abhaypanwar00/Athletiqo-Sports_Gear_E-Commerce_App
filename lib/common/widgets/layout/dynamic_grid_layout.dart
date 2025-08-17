import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:athletiqo/modules/customer/shop/screens/product_details/product_detail_screen.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DynamicGridLayout extends StatelessWidget {
  final List<ProductModel> products;

  const DynamicGridLayout({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final variation = product.productVariations.first;

        return GestureDetector(
          onTap: () => Get.to(() => ProductDetailScreen(productId: product.id)),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Image.network(
                      variation.images.first,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Price
                Positioned(
                  top: 8,
                  left: 8,
                  child: Text(
                    '₹${NumberFormat('#,##0').format(variation.price)}',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.lightGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Color dots
                Positioned(
                  top: 16,
                  right: 10,
                  child: Column(
                    children:
                        product.productVariations
                            .map(
                              (v) => AppHelperFunctions.getColor(v.colorName),
                            )
                            .whereType<Color>()
                            .map(_buildColorDot)
                            .toList(),
                  ),
                ),

                // Product name
                Positioned(
                  bottom: 2,
                  left: 8,
                  right: 8,
                  child: Text(
                    product.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.lightGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildColorDot(Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
