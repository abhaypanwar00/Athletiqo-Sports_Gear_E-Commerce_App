import 'dart:io';
import 'package:athletiqo/data/repository/product/add_product_repository.dart';
import 'package:athletiqo/data/services/cloudinary_service.dart';
import 'package:athletiqo/modules/admin/shop/models/product/bulk_discount_model.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:athletiqo/utils/helpers/network_manager.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/product/product_model.dart';
import '../../models/product/product_variation_model.dart';
import '../../models/product/size_stock_model.dart';
import '../../models/product/rating_model.dart';

class AddProductController extends GetxController {
  // Form Fields & Selections
  var selectedCategory = ''.obs;
  var selectedGender = ''.obs;
  var selectedSubcategory = ''.obs;
  var subcategories = <String>[].obs;
  var manualSizeInput = ''.obs;
  final isLoading = false.obs;
  GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

  // Error Variables
  final categoryError = ''.obs;
  final genderError = ''.obs;
  final subCategoryError = ''.obs;
  final colorError = ''.obs;
  final policyError = ''.obs;
  final sizeError = ''.obs;
  final imageError = ''.obs;

  // Text Editing Controllers
  final productName = TextEditingController();
  final brandName = TextEditingController();
  final description = TextEditingController();
  final loyaltyPoints = TextEditingController();
  final minQuantity = TextEditingController();
  final discount = TextEditingController();

  // Color & Size Details
  var availableColors =
      <Color>[
        Colors.red,
        Colors.grey.shade400,
        Colors.blue.shade900,
        Colors.black,
        Color(0xFFBAB86C),
        Colors.white,
        Colors.pink,
        Color(0xFFDFC5FE),
        Colors.deepOrange,
        Color(0xFF52798D),
      ].obs;

  var selectedColors = <Color>[].obs;
  var colorDetails = <Color, Map<String, dynamic>>{}.obs;

  final RxMap<Color, bool> sameStockForAllMap = <Color, bool>{}.obs;
  final RxMap<Color, String> sharedStockMap = <Color, String>{}.obs;

  // Return Policy
  final List<String> returnPolicies = [
    'No return',
    '7-day return',
    '10-day exchange only',
  ];
  final RxString selectedReturnPolicy = ''.obs;

  /// Updates subcategory list based on selected category and gender
  void updateSubcategories() {
    Map<String, List<String>> defaultSubs = {
      'Accessories': ['Cap', 'Gym Bag', 'Water Bottle'],
      'Fitness': ['Dumbbells', 'Yoga Mat'],
      'Footwear': ['Running Shoes', 'Football Shoes / Studs'],
    };

    Map<String, List<String>> clothingSubs = {
      'Male': ['Jogger & Track Pant', 'Track Suit'],
      'Female': ['Legging', 'Track Suit'],
      'Unisex': ['Track Suit'],
    };

    if (selectedCategory.value == 'Clothing' &&
        clothingSubs.containsKey(selectedGender.value)) {
      subcategories.assignAll(clothingSubs[selectedGender.value]!);
    } else {
      subcategories.assignAll(defaultSubs[selectedCategory.value] ?? []);
    }

    selectedSubcategory.value = '';
  }

  /// Returns available sizes based on category and subcategory
  List<String> getSizeOptions() {
    if (selectedCategory.value == 'Clothing') {
      return ['S', 'M', 'L', 'XL', 'XXL'];
    } else if (selectedCategory.value == 'Footwear') {
      return ['6', '7', '8', '9', '10', '11'];
    } else if (selectedCategory.value == 'Accessories') {
      switch (selectedSubcategory.value) {
        case 'Cap':
          return ['Free Size'];
        case 'Water Bottle':
          return ['500 ml', '750 ml', '1 L', '2 L'];
        case 'Gym Bag':
          return ['OFSA', '10 L', '15 L', '20 L', '25 L'];
        default:
          return ['Free Size'];
      }
    } else if (selectedCategory.value == 'Fitness') {
      switch (selectedSubcategory.value) {
        case 'Dumbbells':
          return ['2 - 24 KG', '5 - 40 KG'];
        case 'Yoga Mat':
          return ['183 x 61 CM', '173 x 61 CM'];
      }
    }
    return [];
  }

  // Color Variant Handling
  /// Adds a new size with empty stock to a color variant
  void addSizeWithStock(Color color, String size) {
    final details = colorDetails[color];
    if (details == null) return;
    List<Map<String, String>> sizes = List<Map<String, String>>.from(
      details['sizes'],
    );
    if (!sizes.any((e) => e['size'] == size)) {
      sizes.add({'size': size, 'stock': ''});
      details['sizes'] = sizes;
      colorDetails[color] = Map<String, dynamic>.from(details);
    }
    colorDetails.refresh();
  }

  /// Removes a size entry from a color variant
  void removeSize(Color color, String size) {
    final details = colorDetails[color];
    if (details == null) return;
    List<Map<String, String>> sizes = List<Map<String, String>>.from(
      details['sizes'],
    );
    sizes.removeWhere((e) => e['size'] == size);
    details['sizes'] = sizes;
    colorDetails[color] = Map<String, dynamic>.from(details);
    colorDetails.refresh();
  }

  /// Updates the stock of a specific size in a color variant
  void updateStock(Color color, String size, String stock) {
    final details = colorDetails[color];
    if (details == null) return;
    List<Map<String, String>> sizes = List<Map<String, String>>.from(
      details['sizes'],
    );
    final index = sizes.indexWhere((e) => e['size'] == size);
    if (index != -1) {
      sizes[index]['stock'] = stock;
      details['sizes'] = sizes;
      colorDetails[color] = Map<String, dynamic>.from(details);
      colorDetails.refresh();
    }
  }

  /// Toggles "same stock for all sizes" flag
  void toggleSameStockForAll(Color color, bool value) {
    sameStockForAllMap[color] = value;
    colorDetails.refresh();
  }

  /// Updates shared stock value when "same stock" is enabled
  void updateSharedStock(Color color, String stock) {
    sharedStockMap[color] = stock;
  }

  /// Updates the price of a color variant
  void updatePrice(Color color, String value) {
    if (colorDetails.containsKey(color)) {
      colorDetails[color]!['price'] = value;
      update();
    }
  }

  // Image Picker
  /// Opens image picker and adds up to 5 images to a color variant
  Future<void> pickImages(Color color) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      final existingImages = List<String>.from(colorDetails[color]!['images']);
      final remaining = 5 - existingImages.length;
      final selected = pickedFiles.take(remaining).map((e) => e.path).toList();
      colorDetails[color]!['images'].addAll(selected);
      colorDetails.refresh();
    }
  }

  /// Removes an image from the selected color variant
  void removeImage(Color color, String path) {
    colorDetails[color]!['images'].remove(path);
    colorDetails.refresh();
  }

  // Upload Product to Firebase
  /// Gathers all product info and uploads it to Firestore and Cloudinary
  Future<void> uploadAndSubmitProduct() async {
    try {
      // Start loading
      isLoading.value = true;

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        AppLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your connection and try again.",
        );
        return;
      }

      // Ensuring empty error fields
      categoryError.value = '';
      subCategoryError.value = '';
      genderError.value = '';
      policyError.value = '';
      colorError.value = '';
      sizeError.value = '';

      // Validate form
      if (!addProductFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // Category Validation
      if (selectedCategory.value.isEmpty) {
        categoryError.value = 'Category is required';
        isLoading.value = false;
        return;
      }

      // Gender Validation
      if (selectedGender.value.isEmpty) {
        genderError.value = 'Gender is required';
        isLoading.value = false;
        return;
      }

      // Subcategory Validation
      if (selectedSubcategory.value.isEmpty) {
        subCategoryError.value = 'Subcategory is required';
        isLoading.value = false;
        return;
      }

      // Colors Validation
      if (selectedColors.isEmpty) {
        colorError.value = 'Please select at least one color';
        isLoading.value = false;
        return;
      }

      // Return Policy Validation
      if (selectedReturnPolicy.value.isEmpty) {
        policyError.value = 'Return Policy is required';
        isLoading.value = false;
        return;
      }

      // Size and Stock Validation
      bool hasInvalidSize = selectedColors.any((color) {
        final details = colorDetails[color];
        if (details == null) return true;
        final sizes = details['sizes'] as List?;
        return sizes == null || sizes.isEmpty;
      });

      if (hasInvalidSize) {
        sizeError.value = 'Please select sizes for all selected colors';
        isLoading.value = false;
        return;
      }

      // Generate ID & initialize dependencies
      String sanitizeForCloudinary(String input) {
        return input
            .toLowerCase()
            .trim()
            .replaceAll(RegExp(r'[^\w\s-]'), '') // remove special characters
            .replaceAll(RegExp(r'\s+'), '-') // replace spaces with dashes
            .replaceAll(RegExp(r'-+'), '-'); // collapse multiple dashes
      }

      final uuid = const Uuid().v4();
      final name = sanitizeForCloudinary(productName.text);
      final productId = '$name-$uuid';

      final cloudinaryService = Get.put(CloudinaryService());
      final productRepository = Get.put(ProductRepository());

      // Prepare variations
      List<ProductVariationModel> variations = [];

      for (final color in selectedColors) {
        final colorName = AppHelperFunctions.getColorName(color);
        final details = colorDetails[color]!;
        final List<String> localPaths = List<String>.from(details['images']);

        // Upload product images to Cloudinary
        final uploadedImagesUrls = await cloudinaryService.uploadMultipleImages(
          images: localPaths.map((e) => File(e)).toList(),
          productId: productId,
          colorName: colorName ?? 'Color',
        );

        // Prepare sizes & stock
        final sizeStockList = List<Map<String, String>>.from(details['sizes']);
        final bool sameStock = sameStockForAllMap[color] ?? false;

        final sizesAndStock =
            sizeStockList.map((e) {
              final size = e['size'] ?? 'Size';
              final stock =
                  sameStock
                      ? int.tryParse(sharedStockMap[color] ?? '0') ?? 0
                      : int.tryParse(e['stock'] ?? '0') ?? 0;
              return SizeStockModel(size: size, stock: stock);
            }).toList();

        final price = double.tryParse(details['price'] ?? '0') ?? 0.0;

        // Build and add variation
        variations.add(
          ProductVariationModel(
            colorName: colorName ?? 'Color',
            price: price,
            images: uploadedImagesUrls,
            sizesAndStock: sizesAndStock,
          ),
        );
      }

      // Build product model
      final product = ProductModel(
        id: productId,
        productName: productName.text.trim(),
        brandName: brandName.text.trim(),
        description: description.text.trim(),
        category: selectedCategory.value,
        subCategory: selectedSubcategory.value,
        gender: selectedGender.value,
        rating: RatingModel(averageRating: 0.0, ratingCount: 0),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productVariations: variations,
        returnPolicy: selectedReturnPolicy.value,
        loyaltyPoints: int.tryParse(loyaltyPoints.text) ?? 0,
        bulkdiscount: BulkDiscountModel(
          minQuantity: int.tryParse(minQuantity.text) ?? 0,
          discount: double.tryParse(discount.text) ?? 0.0,
        ),
      );

      // Upload to Firestore
      await productRepository.addProduct(product);

      // Go to previous screen
      Get.back();

      // Stop loading
      isLoading.value = false;

      // Notify success
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Product added successfully!",
      );
    } catch (e) {
      // Stop loading & show error
      isLoading.value = false;
      AppLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
