import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/home.dart';
import 'package:savingmoney/pages/LandingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(
        initialScreen: LandingPage(),
        onTabChanged: 0,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
