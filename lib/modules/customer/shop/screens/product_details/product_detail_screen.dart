import 'package:athletiqo/common/widgets/cart/product_add_remove_button.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/modules/customer/repository/cart_repository.dart';
import 'package:athletiqo/modules/customer/shop/controllers/cart/cart_controller.dart';
import 'package:athletiqo/modules/customer/shop/controllers/product/product_detail_controller.dart';
import 'package:athletiqo/modules/customer/shop/controllers/wishlist/wishlist_controller.dart';
import 'package:athletiqo/modules/customer/shop/models/cart_item_model.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    final wishlistController = Get.put(WishlistController());
    final cartController = Get.put(CartController());
    Get.put(CartRepository());
    controller.loadProduct(productId);

    return Scaffold(
      appBar: Appbar(
        showBackArrow: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.md),
            child: Obx(
              () => IconButton(
                icon: Icon(
                  wishlistController.isWishlisted(productId)
                      ? Iconsax.heart5
                      : Iconsax.heart,
                  color:
                      wishlistController.isWishlisted(productId)
                          ? Colors.red
                          : AppColors.white,
                ),
                onPressed: () => wishlistController.toggleWishlist(productId),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final product = controller.product.value;
        if (product == null) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.lime),
          );
        }

        final images = controller.imagesForSelectedColor;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Product Images
            SizedBox(
              height: AppSizes.getDynamicSize(350),
              width: AppSizes.getDynamicSize(350),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: images.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder:
                    (_, index) => Image.network(
                      images[index],
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.lime,
                          ),
                        );
                      },
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                    ),
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwSections),

            SmoothPageIndicator(
              controller: controller.pageController,
              count: images.length,
              effect: ExpandingDotsEffect(
                dotHeight: 4,
                dotWidth: 12,
                activeDotColor: Colors.white,
                dotColor: Colors.grey,
              ),
            ),

            SizedBox(height: AppSizes.spaceBtwSections),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.defaultSpace),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name of Product
                          Text(
                            product.productName,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppSizes.spaceBtwItems),

                          // Product Description
                          Text(
                            product.description,
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge!.copyWith(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: AppSizes.spaceBtwSections),

                          // Color Options
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: List.generate(
                                  product.productVariations.length,
                                  (index) {
                                    final variation =
                                        product.productVariations[index];
                                    final isSelected =
                                        controller.selectedColorIndex.value ==
                                        index;
                                    return GestureDetector(
                                      onTap:
                                          () => controller.selectColor(index),
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              isSelected
                                                  ? Border.all(
                                                    color:
                                                        AppHelperFunctions.getColor(
                                                          variation.colorName,
                                                        )!,
                                                    width: 2,
                                                  )
                                                  : null,
                                        ),
                                        child: Center(
                                          child: _buildColorDot(
                                            variation.colorName,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Add Product count
                              AddOrRemoveProductButton(
                                onAdd: controller.increaseQuantity,
                                onRemove: controller.decreaseQuantity,
                                quantity: controller.quantity.value,
                                color: Colors.grey[300],
                                minusIconColor: Colors.black,
                                textColor: Colors.black,
                                addIconContainerColor: AppColors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.spaceBtwItems),

                          // size selection
                          Wrap(
                            spacing: 8.0,
                            children:
                                controller.sizesForSelectedColor.map((size) {
                                  final isSelected =
                                      controller.selectedSize.value == size;
                                  return ChoiceChip(
                                    label: Text(size),
                                    selected: isSelected,
                                    selectedColor: Colors.black,
                                    backgroundColor: Colors.grey[200],
                                    labelStyle: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                    onSelected: (_) {
                                      controller.selectedSize.value = size;
                                    },
                                  );
                                }).toList(),
                          ),

                          SizedBox(height: AppSizes.spaceBtwItems),

                          // price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${controller.selectedColorPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.black),
                              ),

                              // Add to Cart Button
                              ElevatedButton(
                                onPressed: () {
                                  cartController.addToCart(
                                    CartItemModel(
                                      productId: productId,
                                      title: product.productName,
                                      thumbnail:
                                          controller
                                              .product
                                              .value!
                                              .productVariations[controller
                                                  .selectedColorIndex
                                                  .value]
                                              .images
                                              .first,
                                      selectedColor:
                                          controller
                                              .product
                                              .value!
                                              .productVariations[controller
                                                  .selectedColorIndex
                                                  .value]
                                              .colorName,
                                      selectedSize:
                                          controller.selectedSize.value,
                                      price: double.parse(
                                        controller.selectedColorPrice,
                                      ),
                                      quantity: controller.quantity.value,
                                      addedAt: Timestamp.now(),
                                    ),
                                  );
                                  AppHelperFunctions.showSnackBar(
                                    'Product Added to Cart',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fixedSize: Size(180, 60),
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: AppSizes.spaceBtwSections),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       TextHeading(
                          //         text: 'Reviews',
                          //         color: AppColors.black,
                          //         fontWeight: FontWeight.w600,
                          //         fontsize: AppSizes.getDynamicSize(18),
                          //       ),
                          //       Icon(
                          //         Icons.arrow_forward_ios,
                          //         size: AppSizes.getDynamicSize(20),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget _buildColorDot(String colorName) {
  final color = AppHelperFunctions.getColor(colorName);
  return Container(
    width: 25,
    height: 25,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
