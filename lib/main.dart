import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cart_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => CartBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc state Management Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
