import 'package:flutter/material.dart';
import 'package:shoop_app/model/productmodel.dart';

class CartProvider extends ChangeNotifier {
  List cartItems = [];
  int totalAmount = 0;

  addToCart(Product product) {
    cartItems.add(product);

    notifyListeners();
  }

  clearCart() {
    cartItems.clear();
    totalAmount = 0;
    notifyListeners();
  }

  totalsum() {
    for (Product product in cartItems) {
      totalAmount += product.price;
    }
    notifyListeners();
  }
}
