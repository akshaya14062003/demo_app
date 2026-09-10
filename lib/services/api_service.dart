import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://fakestoreapi.com';

  // GET
  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'GET request failed: ${response.statusCode}',
      );
    }
  }

  // POST
  static Future<dynamic> post(
      String endpoint,
      Map<String, dynamic> data,
      ) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'POST request failed: ${response.statusCode}',
      );
    }
  }

  // PUT
  static Future<dynamic> put(
      String endpoint,
      Map<String, dynamic> data,
      ) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'PUT request failed: ${response.statusCode}',
      );
    }
  }

  // DELETE
  static Future<bool> delete(
      String endpoint,
      ) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'DELETE request failed: ${response.statusCode}',
      );
    }
  }
}