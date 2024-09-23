import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc/core/constant/api/api_headers.dart';
import 'package:pcnc/core/constant/api/api_path.dart';
import 'package:pcnc/features/category/data/model/category_model.dart';
import 'package:pcnc/features/product/data/model/product_model.dart';
import 'package:pcnc/features/user/data/model/user_model.dart';

class ApiService {
  final http.Client httpClient = http.Client();

  Future<List<CategoryModel>> getCategories() async {
    final response = await _makeRequest(ApiPath.categoriesUrl, HTTP_GET);
    return _handleResponse<List<CategoryModel>>(
      response,
      (data) => (data as List).map((json) => CategoryModel.fromJson(json)).toList(),
    );
  }

  Future<List<ProductModel>> getProducts({int offset = 0, int limit = 10}) async {
    final url = '${ApiPath.productsUrl}?offset=$offset&limit=$limit';
    final response = await _makeRequest(url, HTTP_GET);
    return _handleResponse<List<ProductModel>>(
      response,
      (data) => (data as List).map((json) => ProductModel.fromJson(json)).toList(),
    );
  }

  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    final url = '${ApiPath.categoriesUrl}/$categoryId/products';
    final response = await _makeRequest(url, HTTP_GET);
    return _handleResponse<List<ProductModel>>(
      response,
      (data) => (data as List).map((json) => ProductModel.fromJson(json)).toList(),
    );
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
    return _handleResponse<UserModel>(response, (data) => UserModel.fromJson(data));
  }

  Future<UserModel> registerUser(String name, String email, String password) async {
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
    return _handleResponse<UserModel>(response, (data) => UserModel.fromJson(data));
  }

  Future<http.Response> _makeRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    String? body,
  }) async {
    switch (method) {
      case HTTP_GET:
        return await httpClient.get(Uri.parse(url), headers: headers);
      case HTTP_POST:
        return await httpClient.post(Uri.parse(url), headers: headers, body: body);
      default:
        throw Exception('Unsupported HTTP method');
    }
  }

  T _handleResponse<T>(http.Response response, T Function(dynamic) dataParser) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return dataParser(data);
    } else {
      throw Exception('Failed to load data: ${response.body}');
    }
  }
}
