// import 'package:get/get.dart';
// import 'package:pcnc/core/enum/e_cache_keys.dart';
// import 'package:pcnc/presentation/controller/cache_controller.dart';

// class UserInfoManager {
//   static final UserInfoManager _instance = UserInfoManager._();
//  final CacheController _cacheController = Get.find<CacheController>();
//   UserInfoManager._();

//   factory UserInfoManager() => _instance;

//   Future<void> setUserInfo(CacheKeys key, String value) async {
//     await _cacheController.setter(key: key, value: value);
//   }

//   String? getUserInfo(CacheKeys key) {
//     return _cacheController.getter(key: key) as String?;
//   }

//   Future<void> clearUserInfo() async {
//     await _cacheController.remove(key: CacheKeys.username);
//     await _cacheController.remove(key: CacheKeys.email);
//   }
// }
import 'package:pcnc/core/enum/e_cache_keys.dart';
import 'package:pcnc/presentation/controller/cache_controller.dart';

class UserInfoManager {
  static final UserInfoManager _instance = UserInfoManager._();

  UserInfoManager._();

  factory UserInfoManager() => _instance;

  final CacheController _cacheController = CacheController();

  Future<void> init() async {
    await _cacheController.initSharedPreferences();
  }

  Future<void> setUserInfo(CacheKeys key, String value) async {
    await _cacheController.setter(key: key, value: value);
  }

  String? getUserInfo(CacheKeys key) {
    return _cacheController.getter(key: key) as String?;
  }

  Future<void> clearUserInfo() async {
    await _cacheController.remove(key: CacheKeys.username);
    await _cacheController.remove(key: CacheKeys.email);
  }
}