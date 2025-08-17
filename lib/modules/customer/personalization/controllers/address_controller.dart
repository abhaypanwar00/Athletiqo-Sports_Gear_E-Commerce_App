import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {
  final addresses = <AddressModel>[].obs;
  final isLoading = false.obs;

  String get _userId => FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  void fetchAddresses() {
    isLoading.value = true;
    _firestore
        .collection('Users')
        .doc(_userId)
        .collection('addresses')
        .snapshots()
        .listen((snapshot) {
          addresses.value =
              snapshot.docs
                  .map((doc) => AddressModel.fromMap(doc.id, doc.data()))
                  .toList();
          isLoading.value = false;
        });
  }

  Future<void> setDefaultAddress(String selectedId) async {
    final userRef = _firestore.collection('Users').doc(_userId);
    final addressRef = userRef.collection('addresses');

    final batch = _firestore.batch();

    // Reset all to false
    for (final address in addresses) {
      batch.update(addressRef.doc(address.id), {
        'isDefault': address.id == selectedId,
      });
    }

    await batch.commit();
  }
}
