import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_managerment_class/bloc/cart_bloc.dart';
import 'package:state_managerment_class/bloc/cart_event.dart';
import 'package:state_managerment_class/bloc/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cart = state.getCart();
          final total = state.getTotalPrice();

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
                        onPressed: () => context.read<CartBloc>().add(RemoveAt(i)),
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
