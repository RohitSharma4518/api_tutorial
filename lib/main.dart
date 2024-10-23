// import 'package:api_tutorial/my_home_page_1.dart';
import 'package:api_tutorial/Screens/list_tasks.dart';
import 'package:api_tutorial/Singleton/splash_screen.dart';
import 'package:api_tutorial/my_home_page_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
