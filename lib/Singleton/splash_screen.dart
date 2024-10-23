import 'dart:async';
import 'dart:developer';

import 'package:api_tutorial/Singleton/home_screen.dart';
import 'package:api_tutorial/Singleton/login_screen.dart';
import 'package:api_tutorial/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SessionController _sessionController = SessionController.instance;
  @override
  void initState() {
    log("init invokde");
  _sessionController.loadSession().then(
      (response) {
        log('inside if block');
        if (_sessionController.userId == null) {
          Timer(const Duration(seconds: 2), () => Get.to(const LoginScreen()));
        } else {
          Timer(const Duration(seconds: 2), () => Get.to(const HomeScreen()));
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "SplashScreen",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
