import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';
class CartBloc extends Bloc<CartEvent, CartState> {
  final List<Product> cartProducts = [];

  CartBloc() : super(CartInitial()) {
   
    on<AddToCartEvent>((event, emit) {
      final existingProduct = cartProducts.firstWhere(
        (product) => product.id == event.product.id,
        orElse: () => Product(
          id: -1,
          title: 'Default',
          price: 0.0,
          discountPercentage: 0.0,
          thumbnail: '',
          category: 'Unknown',
          quantity: 0,
        ),
      );

      if (existingProduct.id != -1) {

        existingProduct.quantity += 1;
      } else {
  
        event.product.quantity = 1;
        cartProducts.add(event.product);
      }

      emit(CartLoaded(products: List.from(cartProducts)));
    });


    on<RemoveFromCartEvent>((event, emit) {
      cartProducts.remove(event.product);
      emit(CartLoaded(products: List.from(cartProducts)));
    });

    on<LoadCartEvent>((event, emit) {
      emit(CartLoaded(products: List.from(cartProducts)));
    });


    on<IncreaseQuantityEvent>((event, emit) {
      final product = cartProducts.firstWhere(
        (item) => item.id == event.product.id,
      );
      product.quantity += 1;
      emit(CartLoaded(products: List.from(cartProducts)));
    });

    on<DecreaseQuantityEvent>((event, emit) {
      final product = cartProducts.firstWhere(
        (item) => item.id == event.product.id,
      );

      if (product.quantity > 1) {
        product.quantity -= 1;
      } else {
      
        cartProducts.remove(product);
      }

      emit(CartLoaded(products: List.from(cartProducts)));
    });
  }
}
