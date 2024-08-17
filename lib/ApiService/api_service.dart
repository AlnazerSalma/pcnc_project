import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<List<dynamic>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load categories');
    }
  }
//   Future<List<dynamic>> getProduct() async {
//     final response = await http.get(Uri.parse('$baseUrl/products'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }
Future<List<dynamic>> getProducts({int offset = 0, int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
