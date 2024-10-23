import 'package:api_tutorial/Singleton/login_screen.dart';
import 'package:api_tutorial/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SessionController sessionController = SessionController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome"),
            ElevatedButton(
              onPressed: ()  {
                sessionController.clearSession();
                Get.to(LoginScreen());
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
