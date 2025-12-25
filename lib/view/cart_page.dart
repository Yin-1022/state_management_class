import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> initialCart;

  const CartPage({super.key, required this.initialCart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> _localCart;

  @override
  void initState() {
    super.initState();
    // 把外面的狀態複製成本地狀態，會造成跨頁不同步
    _localCart = List<CartItem>.from(widget.initialCart);
  }

  void _removeAt(int index) {
    // setState #3：CartPage 自己在改自己的 cart
    setState(() {
      _localCart.removeAt(index);
    });
  }

  int get _totalPrice {
    return _localCart.fold(0, (sum, item) => sum + item.product.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${_localCart.length})'),
      ),
      body: _localCart.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _localCart.length,
              itemBuilder: (context, i) {
                final item = _localCart[i];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('\$${item.product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _removeAt(i),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$$_totalPrice'),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
