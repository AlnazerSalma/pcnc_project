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
      return data; // Access and refresh tokens
    } else {
      throw Exception('Failed to login');
    }
  }
  //   Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/users/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //       'avatar': 'https://picsum.photos/800',
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     final data = json.decode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Failed to register user');
  //   }
  // }
  Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
  // Check if password contains only letters and numbers
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