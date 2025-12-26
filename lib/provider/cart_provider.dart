import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> getCart() => List.unmodifiable(_cart);

  int getCartCount() => _cart.length;

  int getTotalPrice() => _cart.fold(0, (sum, item) => sum + item.product.price);

  void addToCart(Product p) {
    _cart.add(CartItem(product: p));
    notifyListeners();
  }

  void removeAt(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
