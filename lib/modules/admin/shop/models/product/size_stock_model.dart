class SizeStockModel {
  final String size;
  final int stock;

  SizeStockModel({required this.size, required this.stock});

  factory SizeStockModel.fromMap(Map<String, dynamic> map) {
    return SizeStockModel(size: map['size'] ?? '', stock: map['stock'] ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {'size': size, 'stock': stock};
  }
}
