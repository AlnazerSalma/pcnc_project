import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc/aa/core/constant/strings.dart';
import 'package:pcnc/aa/features/category/data/model/category_model.dart';
import 'package:pcnc/aa/features/product/data/model/product_model.dart';

class ApiService {
  final String baseUrl = baseUrll;

 Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
 Future<List<ProductModel>> getProducts({int offset = 0, int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products?offset=$offset&limit=$limit'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
 Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/categories/$categoryId/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }
  Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
  final passwordRegExp = RegExp(r'^[a-zA-Z0-9]+$');
  if (!passwordRegExp.hasMatch(password)) {
    throw Exception('Password must contain only letters and numbers.');
  }
  final response = await http.post(
    Uri.parse('$baseUrl/users/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'email': email,
      'password': password,
      'avatar': 'https://picsum.photos/800',
    }),
  );
  if (response.statusCode == 201) {
    final data = json.decode(response.body);
    return data;
  } else {
    final responseBody = json.decode(response.body);
    print('Failed to register user: ${responseBody}');
    throw Exception('Failed to register user: ${responseBody['message']}');
  }
}

Future<bool> isEmailAvailable(String email) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/users/is-available'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      print('API Response: $data');

      if (data.containsKey('isAvailable')) {
        return data['isAvailable'];
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to check email availability. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Failed to check email availability: $error');
    throw Exception('Failed to check email availability');
  }
}
Future<Map<String, dynamic>> getProfile(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/auth/profile'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load profile');
  }
}
}