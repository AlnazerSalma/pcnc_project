// import 'package:get/get.dart';
// import 'package:pcnc/core/enum/e_cache_keys.dart';
// import 'package:pcnc/presentation/controller/cache_controller.dart';

// class TokenManager {
//   static final TokenManager _instance = TokenManager._();
//   final CacheController _cacheController = Get.find<CacheController>();

//   TokenManager._();

//   factory TokenManager() => _instance;

//   Future<void> setToken(String token) async {
//     await _cacheController.setter(
//       key: CacheKeys.token,
//       value: token,
//     );
//   }

//   String? getToken() {
//     final token = _cacheController.getter(key: CacheKeys.token) as String?;
//     return token != null && token.startsWith('Bearer ')
//         ? token.substring(7)
//         : token;
//   }

//   Future<void> clearToken() async {
//     await _cacheController.remove(key: CacheKeys.token);
//   }

//   bool get isLoggedIn => _cacheController.isLoggedIn;
// }
import 'package:pcnc/core/enum/e_cache_keys.dart';
import 'package:pcnc/presentation/controller/cache_controller.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._();

  TokenManager._();

  factory TokenManager() => _instance;

  final CacheController _cacheController = CacheController();

  Future<void> init() async {
    await _cacheController.initSharedPreferences();
  }

  Future<void> setToken(String token) async {
    await _cacheController.setter(
      key: CacheKeys.token,
      value: token,
    );
  }

  String? getToken() {
    final token = _cacheController.getter(key: CacheKeys.token) as String?;
    return token != null && token.startsWith('Bearer ') ? token.substring(7) : token;
  }

  Future<void> clearToken() async {
    await _cacheController.remove(key: CacheKeys.token);
  }

  bool get isLoggedIn => _cacheController.isLoggedIn;
}