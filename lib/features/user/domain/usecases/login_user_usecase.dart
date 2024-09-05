import 'package:pcnc/features/user/domain/entities/user_entity.dart';
import 'package:pcnc/features/user/domain/repository/user_repository.dart';

class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  Future<User> call(String email, String password) async {
    return await repository.loginUser(email, password);
  }
}


