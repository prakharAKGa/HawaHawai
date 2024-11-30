import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawa_hawai/blocs/cart/cart_bloc.dart';
import 'package:hawa_hawai/blocs/cart/cart_event.dart';
import 'package:hawa_hawai/blocs/cart/cart_state.dart';

import '../models/product.dart';


class CartItemTile extends StatelessWidget {
  final Product product;

  const CartItemTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          // Find the product in the cart
          final updatedProduct = state.products.firstWhere(
            (item) => item.id == product.id,
            orElse: () => product,
          );

          double discountedPrice = updatedProduct.price - 
              (updatedProduct.price * updatedProduct.discountPercentage / 100);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
               
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(updatedProduct.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          updatedProduct.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          updatedProduct.category,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '₹${discountedPrice.toStringAsFixed(2)} ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '₹${updatedProduct.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                text: ' ${updatedProduct.discountPercentage}% OFF',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
               
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(DecreaseQuantityEvent(product: updatedProduct));
                        },
                      ),

                      Text(
                        '${updatedProduct.quantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(IncreaseQuantityEvent(product: updatedProduct));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}




class CartSummaryFooter extends StatelessWidget {
  final List<Product> products;

  const CartSummaryFooter({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = products.fold(
      0,
      (sum, product) => sum + (product.price * product.quantity),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Amount Price\n₹${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
            
            },
            child: Row(
              children: [
                const Text('Check Out', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${products.length}',
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
