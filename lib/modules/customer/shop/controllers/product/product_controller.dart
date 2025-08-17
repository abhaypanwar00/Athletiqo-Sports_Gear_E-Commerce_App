import 'dart:developer';
import 'package:athletiqo/modules/customer/shop/models/brand_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athletiqo/modules/admin/shop/models/product/product_model.dart';

class CustomerProductController extends GetxController {
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<BrandModel> topBrands = <BrandModel>[].obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTopBrands();
    fetchBrands();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      final products =
          snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
              .toList();

      // Sort by lowest variation price (assuming first variation holds the main price)
      products.sort((a, b) {
        final priceA =
            a.productVariations.isNotEmpty
                ? a.productVariations.first.price
                : 0.0;
        final priceB =
            b.productVariations.isNotEmpty
                ? b.productVariations.first.price
                : 0.0;
        return priceA.compareTo(priceB);
      });

      allProducts.value = products;
    } catch (e) {
      log('Error fetching customer products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchTopBrands() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('brands')
              .orderBy('productCount', descending: true)
              .limit(4)
              .get();

      topBrands.value =
          snapshot.docs
              .map((doc) => BrandModel.fromMap(doc.data(), doc.id))
              .toList();
    } catch (e) {
      log('Error fetching top brands: $e');
    }
  }

  void fetchBrands() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('brands').get();
      allBrands.value =
          snapshot.docs
              .map((doc) => BrandModel.fromMap(doc.data(), doc.id))
              .toList();
    } catch (e) {
      log('Error fetching brands: $e');
    }
  }

  BrandModel? getTopBrandWithLogoForCategory(String category) {
    final filteredProducts =
        allProducts
            .where(
              (product) =>
                  product.category.toLowerCase() == category.toLowerCase(),
            )
            .toList();

    final Map<String, int> brandCounts = {};

    for (var product in filteredProducts) {
      brandCounts[product.brandName] =
          (brandCounts[product.brandName] ?? 0) + 1;
    }

    if (brandCounts.isEmpty) return null;

    final sorted =
        brandCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    final topBrandName = sorted.first.key;

    return allBrands.firstWhereOrNull(
      (brand) => brand.brandName.toLowerCase() == topBrandName.toLowerCase(),
    );
  }

  List<String> getTopBrandImagesForCategory(String category, String brandName) {
    final products =
        allProducts
            .where(
              (p) =>
                  p.category.toLowerCase() == category.toLowerCase() &&
                  p.brandName.toLowerCase() == brandName.toLowerCase(),
            )
            .toList();

    final Set<String> uniqueImages = {};

    // Step 1: Try collecting 1 image from different products
    for (var product in products) {
      for (var variation in product.productVariations) {
        if (variation.images.isNotEmpty) {
          uniqueImages.add(variation.images.first);
          break; // move to next product
        }
      }
      if (uniqueImages.length == 3) break;
    }

    // Step 2: Fallback - collect additional images from all variations if needed
    if (uniqueImages.length < 3) {
      for (var product in products) {
        for (var variation in product.productVariations) {
          for (var img in variation.images) {
            if (uniqueImages.length >= 3) break;
            uniqueImages.add(img);
          }
          if (uniqueImages.length >= 3) break;
        }
        if (uniqueImages.length >= 3) break;
      }
    }

    return uniqueImages.toList();
  }

  List<ProductModel> getProductsByCategory(String category) {
    final lowerCategory = category.toLowerCase();

    return allProducts.where((product) {
      return product.category.toLowerCase() == lowerCategory;
    }).toList();
  }

  List<ProductModel> getProductsByBrand(String brand) {
    final lowerBrand = brand.toLowerCase();

    return allProducts.where((product) {
      return product.brandName.toLowerCase() == lowerBrand;
    }).toList();
  }

  List<ProductModel> getProductsByBrandAndCategory(
    String brand,
    String category,
  ) {
    final lowerBrand = brand.toLowerCase();
    final lowerCategory = category.toLowerCase();

    return allProducts.where((product) {
      return product.brandName.toLowerCase() == lowerBrand &&
          product.category.toLowerCase() == lowerCategory;
    }).toList();
  }

  List<ProductModel> getProductsByGender(String gender) {
    final lowerGender = gender.toLowerCase();

    if (lowerGender == 'all') return allProducts;

    if (lowerGender == 'men') {
      return allProducts.where((product) {
        final g = product.gender.toLowerCase();
        return g == 'male' || g == 'unisex';
      }).toList();
    }

    if (lowerGender == 'women') {
      return allProducts.where((product) {
        final g = product.gender.toLowerCase();
        return g == 'female' || g == 'unisex';
      }).toList();
    }

    // fallback empty list
    return [];
  }
}
