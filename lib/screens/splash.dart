import 'package:pcnc/cache/cache_controller.dart';
import 'package:pcnc/enums.dart';
import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/helpers/navigator_helper.dart';
import 'package:pcnc/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigatorHelper {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _init;
  }

  bool _hasAuth = false;

  Future<void> get _init async {
    await _checkAuth;
    _timer;
  }

  Future<void> get _checkAuth async {
  }

  Future<void> get _timer async {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_progress < 1) {
        setState(() => _progress += 0.01);
      } else {
        timer.cancel();
        _navigate;
      }
    });
  }

  Future<void> get _navigate async {
 
    // // String? fcm = await FirebaseMessaging.instance.getToken();
    // // await UsersFbController().updateFcm(uid, fcm);
    // jumpTo(
    //   context,
    //   to: !_hasAuth
    //       ? const AuthScreen()
    //       : BottomNavigationBarDrago(selectedIndex: 0),
    //   replace: true,
    // );
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Image.asset(
          'assets/images/pcnc.jpg',
          width: double.infinity,
          height: 300.h,
        ),
      ),
    ),
  );
}
}
