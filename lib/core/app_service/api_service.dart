import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc/core/constant/strings.dart';
import 'package:pcnc/features/category/data/model/category_model.dart';
import 'package:pcnc/features/product/data/model/product_model.dart';
import 'package:pcnc/features/user/data/model/user_model.dart';

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
 
Future<UserModel> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = json.decode(response.body);
    print('Response data: $data');
    if (data is Map<String, dynamic>) {
      return UserModel.fromJson(data);
    } else {
      throw Exception('Unexpected response format');
    }
  } else {
    final responseBody = json.decode(response.body);
    throw Exception('Failed to login: ${responseBody['message']}');
  }
}

Future<UserModel> registerUser(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/users/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'email': email,
      'password': password,
      'avatar': 'https://imgur.com/LDOO4Qs',
    }),
  );

  if (response.statusCode == 201) {
    final data = json.decode(response.body);
    print('Response data: $data');
    if (data['id'] is String || data['id'] is int) {
      return UserModel.fromJson(data);
    } else {
      throw Exception('Unexpected response format');
    }
  } else {
    final responseBody = json.decode(response.body);
    throw Exception('Failed to register user: ${responseBody['message']}');
  }
}
}


