import 'package:pcnc/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<User> loginUser(String email, String password);
  Future<User> registerUser(String name, String email, String password);
}
