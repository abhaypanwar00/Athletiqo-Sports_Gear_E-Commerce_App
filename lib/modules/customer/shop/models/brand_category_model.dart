class BrandCategoryModel {
  final String brand;
  final String category;
  final int productCount;

  BrandCategoryModel({
    required this.brand,
    required this.category,
    required this.productCount,
  });

  factory BrandCategoryModel.fromMap(Map<String, dynamic> map) {
    return BrandCategoryModel(
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      productCount: map['productCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'brand': brand, 'category': category, 'productCount': productCount};
  }
}
