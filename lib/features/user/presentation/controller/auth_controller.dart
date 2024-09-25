import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:pcnc/core/application_manager/token_manager.dart';
import 'package:pcnc/core/application_manager/user_info_manager.dart';
import 'package:pcnc/core/enum/e_cache_keys.dart';
import 'package:pcnc/data/app_service/api_service.dart';
import 'package:pcnc/features/user/data/repository/user_repository_impl.dart';
import 'package:pcnc/features/user/presentation/views/auth_screen.dart';
import 'package:pcnc/presentation/drawer/widget/zoom_drawer.dart';

class AuthController extends GetxController {
  var isLogin = true.obs;
  var enteredUsernameOrEmail = ''.obs;
  var enteredEmail = ''.obs;
  var enteredPassword = ''.obs;
  var reenteredPassword = ''.obs;
  
  final TokenManager _tokenManager = TokenManager();
  final UserInfoManager _userInfoManager = UserInfoManager();
  final formKey = GlobalKey<FormState>();
  final NavigationManager navigationManager = NavigationManager();
  
  
  @override
  void onInit() {
    super.onInit();
  }

  void toggleLoginMode() {
    isLogin.value = !isLogin.value;
    formKey.currentState?.reset();
    clearFormFields();
  }

  void clearFormFields() {
    enteredUsernameOrEmail.value = '';
    enteredEmail.value = '';
    enteredPassword.value = '';
    reenteredPassword.value = '';
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (!isLogin.value && enteredPassword.value != reenteredPassword.value) {
        Get.snackbar('Error', 'Passwords do not match', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return;
      }

      try {
        final apiRepository = UserRepositoryImpl(apiService: ApiService());
        if (isLogin.value) {
          final user = await apiRepository.loginUser(
            enteredUsernameOrEmail.value,
            enteredPassword.value,
          );
          await _tokenManager.setToken(user.id);
          await _userInfoManager.setUserInfo(CacheKeys.username, enteredUsernameOrEmail.value);
          _navigateToHome();
        } else {
          await apiRepository.registerUser(
            enteredUsernameOrEmail.value,
            enteredEmail.value,
            enteredPassword.value,
          );
          toggleLoginMode();
        }
      } catch (error) {
        Get.snackbar('Error', 'Operation failed', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }
  }
Future<void> remove() async {
    await _tokenManager.clearToken();
    await _userInfoManager.clearUserInfo();
    navigationManager.navigateAndRemoveUntil(AuthScreen());
  }
  Future<void> _navigateToHome() async {
        navigationManager.navigateAndRemoveUntil(ZoomDrawerAnimation());
  }
}
