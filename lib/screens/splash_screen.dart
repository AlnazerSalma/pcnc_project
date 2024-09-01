import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/cache/cache_controller.dart';
import 'package:pcnc/screens/signin_signup_screens/auth.dart';
import 'package:pcnc/drawer/zoom_drawer.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(
        const Duration(seconds: 1));
    _checkAuth();
  }

  void _checkAuth() {
    if (CacheController().isLoggedIn) {
      _navigateToHome();
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToHome() {
    if (!_navigated) {
      _navigated = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ZoomDrawerAnimation()),
      );
    }
  }

  void _navigateToAuth() {
    if (!_navigated) {
      _navigated = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
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
