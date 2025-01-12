import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/functions.dart';
import 'package:tasktie/features/home/home_Screen.dart';
import 'package:tasktie/features/upload/upload_screen.dart';
import '../../core/utils/text_style.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var userBox = Hive.box('user');
    var taskBox = Hive.box('task');

    Future.delayed(
      Duration(seconds: 3),
      () {
        if (userBox.get("isUploaded") != true) {
          pushWithReplacement(context, UploadScreen());
        } else {
          pushWithReplacement(context, HomeScreen());
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("./assets/images/logo.json"),
          const SizedBox(
            height: 8,
          ),
          Text("Taskatie", style: getTitleTesxtStyle()),
          const SizedBox(
            height: 8,
          ),
          Text("it's time to get orgnized", style: getHintTesxtStyle()),
        ],
      ),
    ));
  }
}
