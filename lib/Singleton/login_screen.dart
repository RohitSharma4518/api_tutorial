import 'package:api_tutorial/Singleton/home_screen.dart';
import 'package:api_tutorial/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SessionController _sessionController = SessionController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _sessionController.setSession('123456','asdfrewrws', DateTime.now());
            Get.to(
              const HomeScreen(),
            );
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
