import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc/core/constant/api/api_headers.dart';
import 'package:pcnc/core/constant/api/api_path.dart';
import 'package:pcnc/features/category/data/model/category_model.dart';
import 'package:pcnc/features/product/data/model/product_model.dart';
import 'package:pcnc/features/user/data/model/user_model.dart';

class ApiService {
  Future<List<CategoryModel>> getCategories() async {
    final response = await _makeRequest(ApiPath.categoriesUrl, HTTP_GET);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<ProductModel>> getProducts(
      {int offset = 0, int limit = 10}) async {
    final response = await _makeRequest(
      '${ApiPath.productsUrl}?offset=$offset&limit=$limit',
      HTTP_GET,
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    final response = await _makeRequest(
        '${ApiPath.categoriesUrl}/$categoryId/products', HTTP_GET);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<UserModel> loginUser(String email, String password) async {
    final response = await _makeRequest(
      ApiPath.loginUrl,
      HTTP_POST,
      headers: jsonHeader,
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<UserModel> registerUser(
      String name, String email, String password) async {
    final response = await _makeRequest(
      ApiPath.registerUrl,
      HTTP_POST,
      headers: jsonHeader,
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'avatar': 'https://imgur.com/LDOO4Qs',
      }),
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<http.Response> _makeRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    String? body,
  }) async {
    final request = http.Request(method, Uri.parse(url))
      ..headers.addAll(headers ?? {})
      ..body = body ?? '';

    final response = await http.Response.fromStream(await request.send());
    return response;
  }
}
