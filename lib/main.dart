import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart/cart_bloc.dart';
import 'blocs/product/product_bloc.dart';
import 'repositories/product_repository.dart';
import 'screens/cart_screen.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(productRepository: ProductRepository()),
        ),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
      ],
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
      title: 'Hawa Hawai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const ProductListScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
