import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_managerment_class/bloc/cart_bloc.dart';
import 'package:state_managerment_class/bloc/cart_event.dart';

class CatalogView extends StatelessWidget {
  final List<Product> products;

  const CatalogView({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CategorySection(
          title: 'Drinks',
          products: products,
        ),
      ],
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const CategorySection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ProductList(
            products: products,
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((p) {
        return ProductTile(
          product: p,
        );
      }).toList(),
    );
  }
}

class ProductTile extends StatefulWidget {
  final Product product;

  const ProductTile({
    super.key,
    required this.product,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool _justAdded = false;

  void _handleAdd() {
    context.read<CartBloc>().add(AddToCart(widget.product));

    setState(() => _justAdded = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _justAdded = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Card(
      child: ListTile(
        title: Text(p.name),
        subtitle: Text('\$${p.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_justAdded) const Text('Added!', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _handleAdd,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
