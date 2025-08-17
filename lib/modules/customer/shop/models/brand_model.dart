class BrandModel {
  final String id;
  final String brandName;
  final int productCount;
  final String brandLogo;

  BrandModel({
    required this.id,
    required this.brandLogo,
    required this.brandName,
    required this.productCount,
  });

  factory BrandModel.fromMap(Map<String, dynamic> map, String id) {
    return BrandModel(
      id: id,
      brandLogo: map['brandLogo'] ?? '',
      brandName: map['brandName'] ?? '',
      productCount: map['productCount'] ?? 0,
    );
  }
}
