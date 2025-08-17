import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderRepo {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> placeOrder(OrderModel order) async {
    final userId = _auth.currentUser!.uid;

    // 1. Save to global orders collection
    await _firestore.collection('orders').doc(order.id).set(order.toMap());

    // 2. Save to user subcollection
    await _firestore
        .collection('Users')
        .doc(userId)
        .collection('orders')
        .doc(order.id)
        .set(order.toMap());
  }

  static Stream<List<OrderModel>> getUserOrders() {
    final userId = _auth.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => OrderModel.fromMap(doc.data()))
                  .toList(),
        );
  }

  static Stream<List<OrderModel>> getAllOrdersForAdmin() {
    return _firestore
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => OrderModel.fromMap(doc.data()))
                  .toList(),
        );
  }
}
