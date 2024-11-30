import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository,}) : super(ProductInitial()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchProducts(event.page);
        emit(ProductLoaded(products: products, hasMore: products.isNotEmpty));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
