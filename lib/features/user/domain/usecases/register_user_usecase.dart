import 'package:pcnc/features/user/domain/entities/user_entity.dart';
import 'package:pcnc/features/user/domain/repository/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<User> call(String name, String email, String password) async {
    return await repository.registerUser(name, email, password);
  }
}