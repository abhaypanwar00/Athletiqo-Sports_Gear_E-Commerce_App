import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';
import 'package:athletiqo/modules/customer/repository/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final ProductRepo _repo = ProductRepo();

  final Rx<ProductModel?> product = Rx<ProductModel?>(null);
  final RxInt currentPage = 0.obs;
  final quantity = 1.obs;
  final selectedColorIndex = 0.obs;
  final selectedSize = ''.obs;
  final pageController = PageController();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> loadProduct(String productId) async {
    try {
      final data = await _repo.getProductById(productId);
      product.value = data;
      // Set default selected size for the initial color
      final sizes = sizesForSelectedColor;
      if (sizes.isNotEmpty) {
        selectedSize.value = sizes.first;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void selectColor(int index) {
    selectedColorIndex.value = index;
    final sizes = sizesForSelectedColor;
    if (sizes.isNotEmpty) {
      selectedSize.value = sizes.first;
    } else {
      selectedSize.value = '';
    }
  }

  List<String> get imagesForSelectedColor {
    final variations = product.value?.productVariations ?? [];
    if (variations.isNotEmpty && selectedColorIndex.value < variations.length) {
      return variations[selectedColorIndex.value].images;
    }
    return [];
  }

  String get selectedColorPrice {
    final variations = product.value?.productVariations ?? [];
    if (variations.isNotEmpty) {
      return variations[selectedColorIndex.value].price.toString();
    }
    return '';
  }

  List<String> get sizesForSelectedColor {
    final variations = product.value?.productVariations ?? [];

    if (variations.isNotEmpty) {
      final rawSizes =
          variations[selectedColorIndex.value].sizesAndStock
              .map((s) => s.size)
              .toList();

      // Define custom order for standard size labels
      const customOrder = ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

      rawSizes.sort((a, b) {
        final numA = int.tryParse(a);
        final numB = int.tryParse(b);

        // Case 1: Both are numeric sizes like "7", "8"
        if (numA != null && numB != null) {
          return numA.compareTo(numB);
        }

        // Case 2: One is numeric, one is not — numeric comes first
        if (numA != null) return -1;
        if (numB != null) return 1;

        // Case 3: Both are in custom order list
        final indexA = customOrder.indexOf(a);
        final indexB = customOrder.indexOf(b);

        if (indexA != -1 && indexB != -1) {
          return indexA.compareTo(indexB);
        }

        // Case 4: Alphabetical fallback for unknown labels
        return a.compareTo(b);
      });

      return rawSizes;
    }

    return [];
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) quantity.value--;
  }
}
