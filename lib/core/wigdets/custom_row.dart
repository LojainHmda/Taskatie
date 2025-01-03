import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.widget,

  });

  final String txt1;
    final String txt2;
    final Widget widget;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               txt1,
                style:
                    getCustomTesxtStyle(color: AppColores.primaryColor),
              ),
              Text(
               txt2,
                style:
                    getCustomTesxtStyle(color: AppColores.primaryColor),
              )
            ],
          ),
        ),
        Spacer(),
        widget,
       
      ],
    );
  }
}
