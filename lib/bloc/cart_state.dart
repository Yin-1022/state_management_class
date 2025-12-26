import 'package:state_managerment_class/model/product_model.dart';

class CartState {
  final List<CartItem> cart;

  const CartState({required this.cart});

  static const CartState initial = CartState(cart: []);

  List<CartItem> getCart() => List.unmodifiable(cart);
  int getCartCount() => cart.length;
  int getTotalPrice() => cart.fold(0, (sum, item) => sum + item.product.price);

  CartState copyWith({List<CartItem>? cart}) {
    return CartState(cart: cart ?? this.cart);
  }
}



