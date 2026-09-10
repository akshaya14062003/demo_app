import 'package:demo_app/services/product_api.dart';
import 'package:http/http.dart' ;

import 'api_service.dart';

class CartApi {
  // GET ALL CARTS
  static Future<List<Map<String, dynamic>>> getCarts() async {
    final data = await ApiService.get('/carts');

    return List<Map<String, dynamic>>.from(
      data ?? [],
    );
  }

  // GET CART BY ID
  static Future<Map<String, dynamic>> getCartById(
      int id,
      ) async {
    final data = await ApiService.get('/carts/$id');

    return Map<String, dynamic>.from(
      data ?? {},
    );
  }

  // GET USER CART
  static Future<List<Map<String, dynamic>>> getUserCart(
      int userId,
      ) async {
    final data = await ApiService.get(
      '/carts/user/$userId',
    );

    return List<Map<String, dynamic>>.from(
      data ?? [],
    );
  }

  // ADD CART
  static Future<Map<String, dynamic>> addCart(
      Map<String, dynamic> cart,
      ) async {
    final data = await ApiService.post(
      '/carts',
      cart,
    );

    return Map<String, dynamic>.from(
      data ?? {},
    );
  }

  // UPDATE CART
  static Future<Map<String, dynamic>> updateCart(
      int cartId,
      Map<String, dynamic> cart,
      ) async {
    final data = await ApiService.put(
      '/carts/$cartId',
      cart,
    );

    return Map<String, dynamic>.from(
      data ?? {},
    );
  }

  // DELETE CART
  static Future<bool> deleteCart(
      int cartId,
      ) async {
    return await ApiService.delete(
      '/carts/$cartId',
    );
  }
}