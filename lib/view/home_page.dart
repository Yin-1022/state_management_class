import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';
import 'package:state_managerment_class/view/cart_page.dart';
import 'package:state_managerment_class/widget/catalog_view.dart';
import 'package:provider/provider.dart';
import 'package:state_managerment_class/provider/cart_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> _products = const [
    Product(id: 'p1', name: 'Latte', price: 130),
    Product(id: 'p2', name: 'Americano', price: 90),
    Product(id: 'p3', name: 'Mocha', price: 150),
    Product(id: 'p4', name: 'Tea', price: 70),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog (Provider Mgmt)'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              final cartCount = cartProvider.getCartCount();

              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: 6,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              );
            }
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: CatalogView(
        products: _products,
      ),
    );
  }
}
