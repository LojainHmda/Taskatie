import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/functions.dart';
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
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 10),() {
   pushWithReplacement(context, UploadScreen());
    },);
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
