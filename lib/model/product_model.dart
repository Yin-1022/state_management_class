class Product {
  final String id;
  final String name;
  final int price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

class CartItem {
  final Product product;

  const CartItem({required this.product});
}
