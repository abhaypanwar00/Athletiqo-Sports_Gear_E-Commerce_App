import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Get current user ID
  String get _userId => _auth.currentUser!.uid;

  // Reference to user's wishlist
  CollectionReference get _wishlistRef =>
      _db.collection('Users').doc(_userId).collection('wishlist');

  // Add or remove product from wishlist
  Future<void> toggleWishlist(String productId) async {
    final doc = await _wishlistRef.doc(productId).get();

    if (doc.exists) {
      // Remove from wishlist
      await _wishlistRef.doc(productId).delete();
    } else {
      // Add to wishlist
      await _wishlistRef.doc(productId).set({
        'productId': productId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Check if a product is in wishlist
  Future<bool> isInWishlist(String productId) async {
    final doc = await _wishlistRef.doc(productId).get();
    return doc.exists;
  }

  // Get all wishlist product IDs
  Future<List<String>> getWishlistProductIds() async {
    final querySnapshot = await _wishlistRef.get();
    return querySnapshot.docs.map((doc) => doc.id).toList();
  }
}
