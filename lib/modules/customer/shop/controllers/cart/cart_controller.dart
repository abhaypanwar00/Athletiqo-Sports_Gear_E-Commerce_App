import 'package:athletiqo/modules/customer/repository/cart_repository.dart';
import 'package:athletiqo/modules/customer/shop/models/cart_item_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxDouble totalPrice = 0.0.obs;
  final cartRepository = CartRepository.instance;

  /// Loads the user's cart on startup
  Future<void> loadCart() async {
    final items = await cartRepository.fetchCartItems();
    cartItems.assignAll(items);
    calculateTotal();
  }

  /// Calculates the total price of the cart
  void calculateTotal() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  /// Adds an item to the cart or increases quantity if already present
  Future<void> addToCart(CartItemModel item) async {
    final existingIndex = cartItems.indexWhere(
      (e) =>
          e.productId == item.productId &&
          e.selectedColor == item.selectedColor &&
          e.selectedSize == item.selectedSize,
    );

    if (existingIndex != -1) {
      final existingItem = cartItems[existingIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
      cartItems[existingIndex] = updatedItem;

      await cartRepository.updateCartItem(existingItem, updatedItem);
    } else {
      await cartRepository.addToCart(item);
      cartItems.add(item);
    }

    calculateTotal();
  }

  /// Updates a cart item (e.g. quantity change)
  Future<void> updateCartItem(
    CartItemModel oldItem,
    CartItemModel updatedItem,
  ) async {
    final index = cartItems.indexWhere(
      (e) =>
          e.productId == oldItem.productId &&
          e.selectedColor == oldItem.selectedColor &&
          e.selectedSize == oldItem.selectedSize,
    );

    if (index != -1) {
      // 1. Update UI instantly
      cartItems[index] = updatedItem;
      calculateTotal();

      // 2. Sync with Firestore (async, no reload)
      CartRepository.instance.updateCartItem(oldItem, updatedItem);
    }
  }

  /// Removes a specific item from the cart
  Future<void> removeFromCart(CartItemModel item) async {
    // 1. Instantly update UI
    cartItems.removeWhere(
      (e) =>
          e.productId == item.productId &&
          e.selectedColor == item.selectedColor &&
          e.selectedSize == item.selectedSize,
    );
    calculateTotal();

    // 2. Sync with Firestore in background
    CartRepository.instance.removeFromCart(
      item.productId,
      item.selectedColor,
      item.selectedSize,
    );
  }

  /// Checks if a product is in the cart
  Future<bool> isInCart(CartItemModel item) {
    return CartRepository.instance.isInCart(item);
  }

  /// Clears the entire cart (e.g. after successful checkout)
  Future<void> clearCart() async {
    await CartRepository.instance.clearCart();
    cartItems.clear();
    totalPrice.value = 0.0;
  }
}
