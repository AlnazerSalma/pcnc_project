import 'package:pcnc/features/user/data/model/user_model.dart';
import 'package:pcnc/features/user/domain/repository/user_repository.dart';

class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  Future<UserModel> call(String email, String password) async {
    return await repository.loginUser(email, password);
  }
}


