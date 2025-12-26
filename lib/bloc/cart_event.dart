import 'package:state_managerment_class/model/product_model.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final Product product;
  const AddToCart(this.product);
}

class RemoveAt extends CartEvent {
  final int index;
  const RemoveAt(this.index);
}

class ClearCart extends CartEvent {
  const ClearCart();
}


