import 'package:pcnc/features/user/data/model/user_model.dart';
import 'package:pcnc/features/user/domain/repository/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<UserModel> call(String name, String email, String password) async {
    return await repository.registerUser(name, email, password);
  }
}