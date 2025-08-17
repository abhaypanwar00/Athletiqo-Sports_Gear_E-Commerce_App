class BulkDiscountModel {
  final int minQuantity;
  final double discount;

  BulkDiscountModel({required this.minQuantity, required this.discount});

  // To convert to JSON (for Firebase)
  Map<String, dynamic> toMap() {
    return {'minQuantity': minQuantity, 'discount': discount};
  }

  // To create from JSON (for fetching from Firebase)
  factory BulkDiscountModel.fromMap(Map<String, dynamic> json) {
    return BulkDiscountModel(
      minQuantity: json['minQuantity'] ?? 0,
      discount: (json['discount'] ?? 0).toDouble(),
    );
  }
}
