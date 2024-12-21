import 'package:flutter/material.dart';
import 'package:tasktie/core/colores.dart';
import 'package:lottie/lottie.dart';
import '../core/fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json'),
            CustomTextStyle(text: "Taskatie", color: AppColores.primaryColor, size: 30),
            Text(
              "it's time to get organized",
              style: TextStyle(color: AppColores.hintColor),
            ),
          ],
        ),
      ),
    );
  }
}
