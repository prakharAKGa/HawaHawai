import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawa_hawai/blocs/cart/cart_bloc.dart';
import 'package:hawa_hawai/blocs/cart/cart_state.dart';
import 'package:hawa_hawai/blocs/product/product_bloc.dart';
import 'package:hawa_hawai/blocs/product/product_event.dart';
import 'package:hawa_hawai/blocs/product/product_state.dart';
import 'package:hawa_hawai/widgets/product_tile.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent(page: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.pink[100],
        title: const Text('Product List'),
       actions: [
  BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      int cartItemCount = 0;

      if (state is CartLoaded) {
        cartItemCount = state.products.fold<int>(
          0,
          (previousValue, product) => previousValue + product.quantity,
        );
      }

      return IconButton(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.shopping_cart),
            if (cartItemCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    cartItemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      );
    },
  ),
],

      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(product: state.products[index]);
                  },
                ),
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No Products Found'));
        },
      ),
    );
  }
}
