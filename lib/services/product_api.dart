import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApi {
  static const String baseUrl =
      'https://fakestoreapi.com';

  static Future<List<Map<String, dynamic>>>
  getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
      jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception(
        'Failed to load products',
      );
    }
  }
}