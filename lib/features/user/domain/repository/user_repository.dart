import 'package:pcnc/features/user/data/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> loginUser(String email, String password);
  Future<UserModel> registerUser(String name, String email, String password);
}
