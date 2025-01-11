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
    this.decoration,
    this.icon,
  });

  final String txt1;
  final String txt2;
  final Widget widget;
  final Decoration? decoration;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      padding: EdgeInsets.all(15),
      decoration: decoration,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt1,
                style: getCustomTesxtStyle(color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  icon ?? SizedBox.shrink(),
                  Text(
                    txt2,
                    style:
                        getCustomTesxtStyle(color: Colors.black),
                  )
                ],
              ),
            ],
          ),
          Spacer(),
          widget,
        ],
      ),
    );
  }
}
