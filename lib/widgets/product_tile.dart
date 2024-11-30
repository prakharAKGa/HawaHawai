import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double discountedPrice = product.price - (product.price * product.discountPercentage / 100);

    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    product.thumbnail,  
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                    
                      context.read<CartBloc>().add(AddToCartEvent(product: product));
                   
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.title} added to cart!')),
                      );
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Color.fromARGB(255, 171, 4, 74),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
               Text(
                product.category,
                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600,
                color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '₹${product.price.toStringAsFixed(3)}',
                    style: const TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey,
                    ),
                  ),
                  Text(
                    ' ₹${discountedPrice.toStringAsFixed(3)}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('${product.discountPercentage}% OFF', style: const TextStyle(fontSize: 12, color: Colors.pink)),
            ],
          ),
        ),
      ),
    );
  }
}
