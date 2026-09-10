import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartData {
  static final List<Map<String, dynamic>> cartProducts = [];

  static final ValueNotifier<int> cartCountNotifier =
  ValueNotifier<int>(0);

  static void addToCart(Map<String, dynamic> product) {
    final String productName =
        product['name']?.toString() ?? '';

    final int existingIndex = cartProducts.indexWhere(
          (item) => item['name']?.toString() == productName,
    );

    if (existingIndex != -1) {
      final int oldQuantity =
      getQuantity(cartProducts[existingIndex]);

      cartProducts[existingIndex]['quantity'] =
          oldQuantity + 1;
    } else {
      final Map<String, dynamic> newProduct =
      Map<String, dynamic>.from(product);

      newProduct['quantity'] = 1;

      cartProducts.add(newProduct);
    }

    updateCartCount();
  }

  static int getQuantity(Map<String, dynamic> product) {
    final dynamic value = product['quantity'];

    if (value is int) {
      return value;
    }

    if (value is String) {
      return int.tryParse(value) ?? 1;
    }

    return 1;
  }


  static void increaseQuantity(int index) {
    if (index < 0 || index >= cartProducts.length) {
      return;
    }

    final int quantity = getQuantity(cartProducts[index]);

    cartProducts[index]['quantity'] = quantity + 1;

    updateCartCount();
  }

  static void decreaseQuantity(int index) {
    if (index < 0 || index >= cartProducts.length) {
      return;
    }

    final int quantity = getQuantity(cartProducts[index]);

    if (quantity > 1) {
      cartProducts[index]['quantity'] = quantity - 1;
    } else {
      cartProducts.removeAt(index);
    }

    updateCartCount();
  }

  static void removeFromCart(int index) {
    if (index < 0 || index >= cartProducts.length) {
      return;
    }

    cartProducts.removeAt(index);

    updateCartCount();
  }



  static void clearCart() {
    cartProducts.clear();

    cartCountNotifier.value = 0;
  }


  static void updateCartCount() {
    int totalQuantity = 0;

    for (final product in cartProducts) {
      totalQuantity += getQuantity(product);
    }

    cartCountNotifier.value = totalQuantity;

    Fluttertoast.showToast(
      msg: "Cart Updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static int get itemCount {
    int totalQuantity = 0;

    for (final product in cartProducts) {
      totalQuantity += getQuantity(product);
    }

    return totalQuantity;
  }
}