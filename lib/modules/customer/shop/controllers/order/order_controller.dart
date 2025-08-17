import 'package:athletiqo/modules/customer/personalization/models/address_model.dart';
import 'package:athletiqo/modules/customer/shop/controllers/cart/cart_controller.dart';
import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxList<OrderModel> userOrders = <OrderModel>[].obs;
  final RxList<OrderModel> allOrders = <OrderModel>[].obs;

  Future<void> placeOrder(AddressModel selectedAddress) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final cartController = Get.find<CartController>();
    final id = const Uuid().v4();
    final total = cartController.totalPrice.value + 50 + 37;

    final order = OrderModel(
      id: id,
      userId: user.uid,
      items: cartController.cartItems.toList(),
      totalAmount: total,
      address: selectedAddress,
      status: 'Pending',
      orderDate: DateTime.now(),
    );

    await _firestore.collection('orders').doc(id).set(order.toMap());

    /// Store in user subcollection for quick access
    await _firestore
        .collection('Users')
        .doc(user.uid)
        .collection('orders')
        .doc(id)
        .set(order.toMap());

    // Clear cart after order
    await cartController.clearCart();

    // Optionally refresh user order list
    await fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot =
        await _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('orders')
            .orderBy('orderDate', descending: true)
            .get();

    userOrders.assignAll(
      snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList(),
    );
  }

  Future<void> fetchAllOrders() async {
    final snapshot =
        await _firestore
            .collection('orders')
            .orderBy('orderDate', descending: true)
            .get();

    allOrders.assignAll(
      snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList(),
    );
  }
}
