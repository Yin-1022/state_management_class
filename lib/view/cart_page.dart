import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:state_managerment_class/provider/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
        final cart = cartProvider.getCart();
        final total = cartProvider.getTotalPrice();

        return Scaffold(
          appBar: AppBar(
            title: Text('Cart (${cart.length})'),
          ),
          body: cart.isEmpty
              ? const Center(child: Text('Cart is empty'))
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, i) {
                    final item = cart[i];
                    return ListTile(
                      title: Text(item.product.name),
                      subtitle: Text('\$${item.product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => context.read<CartProvider>().removeAt(i),
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
                    Text('Total: \$$total'),
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
    );
  }
}
