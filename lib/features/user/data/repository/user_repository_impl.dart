import 'package:pcnc/core/app_service/api_service.dart';
import 'package:pcnc/features/user/data/model/user_model.dart';


abstract class ApiRepository {
  Future<UserModel> loginUser(String email, String password);
  Future<UserModel> registerUser(String name, String email, String password);
}

class ApiRepositoryImpl implements ApiRepository {
  final ApiService apiService;

  ApiRepositoryImpl({required this.apiService});

  @override
  Future<UserModel> loginUser(String email, String password) {
    return apiService.loginUser(email, password);
  }

  @override
  Future<UserModel> registerUser(String name, String email, String password) {
    return apiService.registerUser(name, email, password);
  }
}
