import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'package:provider/provider.dart';
import 'provider/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider state Management Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
