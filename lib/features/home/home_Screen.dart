import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_button.dart';
import 'package:tasktie/core/wigdets/custom_row.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatefulWidget {
  String controller;
  HomeScreen(this.controller, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box('user');
    late var selectedValue;
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomRow(
              txt1: "hello,${userBox.get('name')}",
              txt2: "Have a Nice day!",
              widget: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(userBox.get("image")))),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomRow(
              txt1: "${DateFormat("MMM,dd,yyyy").format(DateTime.now())}",
              txt2: "Today",
              widget: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                    txt: " + Add Task",
                    onPressed: () {},
                    width: 145,
                    height: 60),
              )),
          SizedBox(
            height: 10,
          ),
          DatePicker(
            
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColores.hintColor,
            selectedTextColor: AppColores.primaryColor,
            onDateChange: (date) {
              setState(() {
                selectedValue = date;
              });
            },
          ),
        ],
      ),
    );
  }
}
