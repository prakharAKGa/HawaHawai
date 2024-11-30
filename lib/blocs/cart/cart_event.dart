import 'package:equatable/equatable.dart';

import '../../models/product.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Product product;

  AddToCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final Product product;

  RemoveFromCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class LoadCartEvent extends CartEvent {}

class IncreaseQuantityEvent extends CartEvent {
  final Product product;

  IncreaseQuantityEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class DecreaseQuantityEvent extends CartEvent {
  final Product product;

  DecreaseQuantityEvent({required this.product});

  @override
  List<Object> get props => [product];
}