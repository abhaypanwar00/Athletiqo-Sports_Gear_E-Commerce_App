import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  static AddAddressController get instance => Get.find();

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final name = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// User ID - Replace this with actual current user ID getter
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  /// Save Address to Firestore
  Future<void> saveAddress() async {
    if (!formKey.currentState!.validate()) return;

    final addressData = {
      'name': name.text.trim(),
      'phone': phone.text.trim(),
      'street': street.text.trim(),
      'postalCode': postalCode.text.trim(),
      'city': city.text.trim(),
      'state': state.text.trim(),
      'createdAt': Timestamp.now(),
    };

    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('addresses')
          .add(addressData);

      Get.snackbar("Success", "Address saved successfully");
      clearForm();
    } catch (e) {
      Get.snackbar("Error", "Failed to save address: $e");
    }
  }

  /// Clear form after saving
  void clearForm() {
    name.clear();
    phone.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    street.dispose();
    postalCode.dispose();
    city.dispose();
    state.dispose();
    super.dispose();
  }
}
