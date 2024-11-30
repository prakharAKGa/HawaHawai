import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductRepository {
  final String apiUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts(int page, {int limit = 50}) async {
    try {
      final skip = page * limit;
      final response = await http.get(Uri.parse('$apiUrl?skip=$skip&limit=$limit'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
