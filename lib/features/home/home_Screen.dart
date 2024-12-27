import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
 String controller;
    HomeScreen(this.controller,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(controller),));
  }
}