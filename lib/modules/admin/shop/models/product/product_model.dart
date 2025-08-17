import 'package:athletiqo/modules/admin/shop/models/product/bulk_discount_model.dart';
import 'package:athletiqo/modules/admin/shop/models/product/product_variation_model.dart';
import 'package:athletiqo/modules/admin/shop/models/product/rating_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String productName;
  final String brandName;
  final String description;
  final String category;
  final String subCategory;
  final String gender;
  final RatingModel rating;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductVariationModel> productVariations;
  final String returnPolicy;
  final int loyaltyPoints;
  final BulkDiscountModel bulkdiscount;

  ProductModel({
    required this.id,
    required this.productName,
    required this.description,
    required this.brandName,
    required this.category,
    required this.subCategory,
    required this.gender,
    required this.rating,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    required this.productVariations,
    required this.returnPolicy,
    required this.loyaltyPoints,
    required this.bulkdiscount,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: docId,
      productName: map['productName'] ?? '',
      description: map['description'] ?? '',
      brandName: map['brand'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      gender: map['gender'] ?? '',
      rating: RatingModel.fromMap(map['rating'] ?? {}),
      isActive: map['isActive'] ?? true,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      returnPolicy: map['returnPolicy'] ?? '',
      loyaltyPoints: (map['loyaltyPoints'] ?? 0).toInt(),
      bulkdiscount: BulkDiscountModel.fromMap(map['bulkdiscount'] ?? {}),
      productVariations:
          (map['productVariations'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromMap(e))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'brand': brandName,
      'category': category,
      'subCategory': subCategory,
      'gender': gender,
      'rating': rating.toMap(),
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'returnPolicy': returnPolicy,
      'loyaltyPoints': loyaltyPoints,
      'bulkdiscount': bulkdiscount.toMap(),
      'productVariations': productVariations.map((e) => e.toMap()).toList(),
    };
  }
}
