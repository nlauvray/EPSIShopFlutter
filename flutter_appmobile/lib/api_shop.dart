import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load products');
  }
}

Future<void> saveCart(List<dynamic> cart) async {
  final response = await http.post(
    Uri.parse('https://fakestoreapi.com/products/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(cart),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to save cart');
  }
}

Future<List<dynamic>> loadCart() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/1'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load cart');
  }
}