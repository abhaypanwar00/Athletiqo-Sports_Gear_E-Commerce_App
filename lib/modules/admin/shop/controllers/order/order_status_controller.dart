import 'dart:developer';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStatusController extends GetxController {
  final RxString selectedStatus = ''.obs;

  void setInitialStatus(String status) {
    selectedStatus.value = status;
  }

  Future<void> updateStatus({
    required String newStatus,
    required String orderId,
    required String userId,
  }) async {
    try {
      selectedStatus.value = newStatus;

      // Update in main orders collection
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update(
        {'status': newStatus},
      );

      // Update in user's orders subcollection
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({'status': newStatus});

      log('Status updated to $newStatus');
    } catch (e) {
      log('Failed to update status: $e');
      Get.snackbar('Error', 'Could not update order status');
    }
  }
}
