import 'package:athletiqo/modules/customer/shop/controllers/wishlist/wishlist_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();

    final firstImage =
        product.productVariations.isNotEmpty &&
                product.productVariations[0].images.isNotEmpty
            ? product.productVariations[0].images[0]
            : '';

    final price =
        product.productVariations.isNotEmpty
            ? product.productVariations[0].price
            : 0.0;

    return Card(
      color: AppColors.darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Container(
                    color: AppColors.darkGrey,
                    child:
                        firstImage.isNotEmpty
                            ? Padding(
                              padding: EdgeInsets.all(AppSizes.lg),
                              child: Image.network(
                                firstImage,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.lime,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image, size: 40),
                                  );
                                },
                              ),
                            )
                            : const Center(
                              child: Icon(Icons.image_not_supported, size: 40),
                            ),
                  ),
                ),
              ),
              // Price
              Positioned(
                top: 10,
                left: 10,
                child: Text(
                  '₹${NumberFormat('#,##0').format(price)}',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.lightGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: Row(
                  children:
                      product.productVariations
                          .map((v) => AppHelperFunctions.getColor(v.colorName))
                          .whereType<Color>()
                          .map(_buildColorDot)
                          .toList(),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => wishlistController.toggleWishlist(product.id),
                  child: Icon(Iconsax.heart5, color: Colors.red),
                ),
              ),
            ],
          ),
          // Product Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              product.productName,
              maxLines: 2,
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
    );
  }
}

Widget _buildColorDot(Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6),
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
