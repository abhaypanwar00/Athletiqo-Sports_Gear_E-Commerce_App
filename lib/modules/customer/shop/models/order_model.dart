import 'package:athletiqo/modules/customer/personalization/models/address_model.dart';
import 'package:athletiqo/modules/customer/shop/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final double totalAmount;
  final AddressModel address;
  final String status;
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.address,
    required this.status,
    required this.orderDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'totalAmount': totalAmount,
      'address': address.toMap(),
      'status': status,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['userId'],
      items: List<CartItemModel>.from(
        (map['items'] as List<dynamic>).map(
          (item) => CartItemModel.fromMap(item),
        ),
      ),
      totalAmount: map['totalAmount'],
      address: AddressModel.fromMap('default', map['address']),
      status: map['status'],
      orderDate: DateTime.parse(map['orderDate']),
    );
  }
}
