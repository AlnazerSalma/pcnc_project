// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pcnc/core/application_manager/navigation_manager.dart';
// import 'package:pcnc/core/application_manager/token_manager.dart';
// import 'package:pcnc/core/application_manager/user_info_manager.dart';
// import 'package:pcnc/features/user/presentation/views/auth_screen.dart';
// import 'package:pcnc/generated/assets.dart';
// import 'package:pcnc/presentation/controller/cache_controller.dart';
// import 'package:pcnc/presentation/drawer/widget/zoom_drawer.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool _navigated = false;
//   final NavigationManager _navigationManager = NavigationManager();
//   final CacheController _cacheController = Get.put(CacheController());

//   @override
//   void initState() {
//     super.initState();
//     _initializeManagers();
//   }

//   Future<void> _initializeManagers() async {
//     await _cacheController.onInit();
//     await Future.delayed(const Duration(seconds: 1));
//     _checkAuth();
//   }

//   // void _checkAuth() {
//   //    if (_cacheController.isLoggedIn) {
//   //     _navigateToHome();
//   //   } else {
//   //     _navigateToAuth();
//   //   }
//   // }
//   void _checkAuth() {
//   if (TokenManager().isLoggedIn) {
//     _navigateToHome();
//   } else {
//     _navigateToAuth();
//   }
// }


//   void _navigateToHome() {
//     if (!_navigated) {
//       _navigated = true;
//       _navigationManager.replaceWith(ZoomDrawerAnimation());
//     }
//   }

//   void _navigateToAuth() {
//     if (!_navigated) {
//       _navigated = true;
//       _navigationManager.replaceWith(AuthScreen());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context, designSize: const Size(375, 790));
//     return Scaffold(
//       body: Container(
//         color: Theme.of(context).colorScheme.background,
//         child: Center(
//           child: Image.asset(
//             Assets.pcnc,
//             width: double.infinity,
//             height: 300.h,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:pcnc/core/application_manager/token_manager.dart';
import 'package:pcnc/core/application_manager/user_info_manager.dart';
import 'package:pcnc/features/user/presentation/views/auth_screen.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/presentation/drawer/widget/zoom_drawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  bool _navigated = false;

  final TokenManager _tokenManager = TokenManager();
  final UserInfoManager _userInfoManager = UserInfoManager();
  late NavigationManager _navigationManager;

  @override
  void initState() {
    super.initState();
    _navigationManager = NavigationManager();
    _initializeManagers();
  }

  Future<void> _initializeManagers() async {
    await _tokenManager.init();
    await _userInfoManager.init();
    await Future.delayed(const Duration(seconds: 1));
    _checkAuth();
  }

  void _checkAuth() {
    if (_tokenManager.isLoggedIn) {
      _navigateToHome();
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToHome() {
    if (!_navigated) {
      _navigated = true;
      _navigationManager.replaceWith(ZoomDrawerAnimation());
    }
  }

  void _navigateToAuth() {
    if (!_navigated) {
      _navigated = true;
      _navigationManager.replaceWith(AuthScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Image.asset(
            Assets.pcnc,
            width: double.infinity,
            height: 300.h,
          ),
        ),
      ),
    );
  }
}