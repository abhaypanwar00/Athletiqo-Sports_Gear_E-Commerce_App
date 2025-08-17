import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String productId;
  final String title;
  final String thumbnail;
  final String selectedColor;
  final String selectedSize;
  final double price;
  final int quantity;
  final Timestamp addedAt;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.selectedColor,
    required this.selectedSize,
    required this.price,
    required this.quantity,
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'thumbnail': thumbnail,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'price': price,
      'quantity': quantity,
      'addedAt': addedAt,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      selectedColor: map['selectedColor'],
      selectedSize: map['selectedSize'],
      price: map['price'],
      quantity: map['quantity'],
      addedAt: map['addedAt'],
    );
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? title,
    String? selectedColor,
    String? selectedSize,
    double? price,
    int? quantity,
    Map<String, dynamic>? productData,
    Timestamp? addedAt,
  }) {
    return CartItemModel(
      thumbnail: thumbnail,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
