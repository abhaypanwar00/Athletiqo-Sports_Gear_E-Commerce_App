import 'package:athletiqo/modules/customer/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  var allOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    fetchAllOrders();
    super.onInit();
  }

  void fetchAllOrders() async {
    final snapshot = await FirebaseFirestore.instance.collection('orders').get();
    allOrders.value = snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
  }

  List<OrderModel> getByStatus(String status) {
    return allOrders.where((order) => order.status.toLowerCase() == status.toLowerCase()).toList();
  }
}