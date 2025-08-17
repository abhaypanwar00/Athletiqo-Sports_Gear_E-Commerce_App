import 'package:athletiqo/modules/admin/shop/models/product/size_stock_model.dart';

class ProductVariationModel {
  final String colorName;
  final double price;
  final List<String> images;
  final List<SizeStockModel> sizesAndStock;

  ProductVariationModel({
    required this.colorName,
    required this.price,
    required this.images,
    required this.sizesAndStock,
  });

  factory ProductVariationModel.fromMap(Map<String, dynamic> map) {
    return ProductVariationModel(
      colorName: map['colorName'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      images: List<String>.from(map['images'] ?? []),
      sizesAndStock:
          (map['sizesAndStock'] as List<dynamic>)
              .map((e) => SizeStockModel.fromMap(e))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'colorName': colorName,
      'price': price,
      'images': images,
      'sizesAndStock': sizesAndStock.map((e) => e.toMap()).toList(),
    };
  }
}
