import 'package:pcnc/data/app_service/api_service.dart';
import 'package:pcnc/features/user/data/model/user_model.dart';
import 'package:pcnc/features/user/domain/repository/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<UserModel> loginUser(String email, String password) {
    return apiService.loginUser(email, password);
  }

  @override
  Future<UserModel> registerUser(String name, String email, String password) {
    return apiService.registerUser(name, email, password);
  }
}
