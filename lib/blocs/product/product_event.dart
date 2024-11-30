import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  final int page;

  LoadProductsEvent({required this.page});

  @override
  List<Object> get props => [page];
}
