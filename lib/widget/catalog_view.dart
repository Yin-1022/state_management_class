import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';

/// 這個檔案刻意做「多層 widget」
/// HomePage -> CatalogView -> CategorySection -> ProductList -> ProductTile
class CatalogView extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onAddToCart;

  const CatalogView({
    super.key,
    required this.products,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CategorySection(
          title: 'Drinks',
          products: products,
          onAddToCart: onAddToCart, // 參數一路往下傳 #1
        ),
      ],
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final void Function(Product) onAddToCart;

  const CategorySection({
    super.key,
    required this.title,
    required this.products,
    required this.onAddToCart,
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
            onAddToCart: onAddToCart, // 參數一路往下傳 #2
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onAddToCart;

  const ProductList({
    super.key,
    required this.products,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((p) {
        return ProductTile(
          product: p,
          onAddToCart: onAddToCart, // 參數一路往下傳 #3（傳到最底）
        );
      }).toList(),
    );
  }
}

class ProductTile extends StatefulWidget {
  final Product product;
  final void Function(Product) onAddToCart;

  const ProductTile({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool _justAdded = false;

  void _handleAdd() {
    widget.onAddToCart(widget.product);

    // setState #2：改「本地 UI 狀態」
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
