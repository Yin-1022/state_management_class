import 'package:flutter/material.dart';
import 'package:state_managerment_class/model/product_model.dart';
import 'package:state_managerment_class/view/cart_page.dart';
import 'package:state_managerment_class/widget/catalog_view.dart';

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

  final List<CartItem> _cart = [];

  void _addToCart(Product p) {
    // setState #1：更新 cart 狀態
    setState(() {
      _cart.add(CartItem(product: p));
    });
  }

  @override
  Widget build(BuildContext context) {
    final int cartCount = _cart.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog (No State Mgmt)'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () async {
                  // 跨頁：把 cart 傳進下一頁
                  // 問題：CartPage 如果要修改 cart，得想辦法回傳或傳 callback
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(
                        initialCart: _cart,
                      ),
                    ),
                  );
                  // 注意：這裡沒有任何 setState
                  // 因為我們「不知道 CartPage 」有沒有改到 HomePage 的 cart
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
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: CatalogView(
        // Widget間傳遞
        products: _products,
        onAddToCart: _addToCart,
      ),
    );
  }
}
