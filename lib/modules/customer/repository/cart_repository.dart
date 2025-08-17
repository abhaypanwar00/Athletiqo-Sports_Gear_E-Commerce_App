import 'dart:developer';

import 'package:athletiqo/modules/customer/shop/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String get _userId => _auth.currentUser!.uid;

  /// Adds a new item to the cart or merges if same item already exists
  Future<void> addToCart(CartItemModel item) async {
    final cartRef = _db.collection('Users').doc(_userId).collection('cart');

    // Check for existing item with same product, color and size
    final existing =
        await cartRef
            .where('productId', isEqualTo: item.productId)
            .where('selectedColor', isEqualTo: item.selectedColor)
            .where('selectedSize', isEqualTo: item.selectedSize)
            .get();

    if (existing.docs.isNotEmpty) {
      final existingDoc = existing.docs.first;
      final existingItem = CartItemModel.fromMap(existingDoc.data());

      // Merge quantities
      await cartRef.doc(existingDoc.id).update({
        'quantity': existingItem.quantity + item.quantity,
        'addedAt': Timestamp.now(),
      });
    } else {
      log("Item added");
      await cartRef.add(item.toMap());
    }
  }

  /// Fetches all cart items for a user
  Future<List<CartItemModel>> fetchCartItems() async {
    final snapshot =
        await _db
            .collection('Users')
            .doc(_userId)
            .collection('cart')
            .orderBy('addedAt', descending: true)
            .get();

    return snapshot.docs
        .map((doc) => CartItemModel.fromMap(doc.data()))
        .toList();
  }

  /// Removes an item from the cart
  Future<void> removeFromCart(
    String productId,
    String color,
    String size,
  ) async {
    final cartRef = _db.collection('Users').doc(_userId).collection('cart');
    final snapshot =
        await cartRef
            .where('productId', isEqualTo: productId)
            .where('selectedColor', isEqualTo: color)
            .where('selectedSize', isEqualTo: size)
            .get();

    for (var doc in snapshot.docs) {
      await cartRef.doc(doc.id).delete();
    }
  }

  /// Updates an existing cart item (color, size, quantity, etc.)
  /// and merges if the updated item matches an existing one
  Future<void> updateCartItem(
    CartItemModel oldItem,
    CartItemModel updatedItem,
  ) async {
    final cartRef = _db.collection('Users').doc(_userId).collection('cart');

    // If the item hasn't changed in identity (same product, size, color), just update quantity
    if (oldItem.productId == updatedItem.productId &&
        oldItem.selectedColor == updatedItem.selectedColor &&
        oldItem.selectedSize == updatedItem.selectedSize) {
      final snapshot =
          await cartRef
              .where('productId', isEqualTo: oldItem.productId)
              .where('selectedColor', isEqualTo: oldItem.selectedColor)
              .where('selectedSize', isEqualTo: oldItem.selectedSize)
              .get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id;
        await cartRef.doc(docId).update({
          'quantity': updatedItem.quantity,
          'addedAt': Timestamp.now(),
        });
      }
      return;
    }

    // If the identity has changed (e.g. size/color), do merge logic
    final existing =
        await cartRef
            .where('productId', isEqualTo: updatedItem.productId)
            .where('selectedColor', isEqualTo: updatedItem.selectedColor)
            .where('selectedSize', isEqualTo: updatedItem.selectedSize)
            .get();

    if (existing.docs.isNotEmpty) {
      final existingDoc = existing.docs.first;
      final existingItem = CartItemModel.fromMap(existingDoc.data());

      await cartRef.doc(existingDoc.id).update({
        'quantity': existingItem.quantity + updatedItem.quantity,
        'addedAt': Timestamp.now(),
      });
    } else {
      await cartRef.add(updatedItem.toMap());
    }

    // Delete the old item after merge
    final oldSnapshot =
        await cartRef
            .where('productId', isEqualTo: oldItem.productId)
            .where('selectedColor', isEqualTo: oldItem.selectedColor)
            .where('selectedSize', isEqualTo: oldItem.selectedSize)
            .get();

    for (var doc in oldSnapshot.docs) {
      await cartRef.doc(doc.id).delete();
    }
  }

  /// Checks if a specific item is already in the cart
  Future<bool> isInCart(CartItemModel item) async {
    final snapshot =
        await _db
            .collection('Users')
            .doc(_userId)
            .collection('cart')
            .where('productId', isEqualTo: item.productId)
            .where('selectedColor', isEqualTo: item.selectedColor)
            .where('selectedSize', isEqualTo: item.selectedSize)
            .get();

    return snapshot.docs.isNotEmpty;
  }

  /// Clears the cart for a user
  Future<void> clearCart() async {
    final cartRef = _db.collection('Users').doc(_userId).collection('cart');
    final snapshot = await cartRef.get();
    for (var doc in snapshot.docs) {
      await cartRef.doc(doc.id).delete();
    }
  }
}
