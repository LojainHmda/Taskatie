import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasktie/core/functions.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_button.dart';
import 'package:tasktie/core/wigdets/custom_row.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:tasktie/features/addTask/add_task_screen.dart';
import 'package:tasktie/features/upload/upload_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen( {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override  
 late var selectedValue ;  
  Widget build(BuildContext context) {

    var userBox = Hive.box('user');
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
          ElevatedButton(onPressed: (){pushTo(context, UploadScreen());}, child: Text("nav")),
          CustomRow(
              txt1: "${DateFormat("MMM,dd,yyyy").format(DateTime.now())}",
              txt2: "Today",
              widget: CustomButton(
                  txt: " + Add Task",
                  onPressed: () {
                    pushTo(context, AddTaskScreen());
                  },
                  width: 145,
                  height: 60)),
          DatePicker(
            DateTime.now(),
            height: 120,
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
          Expanded(
              child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: CustomRow(
                  icon: Icon(Icons.watch_later_outlined),
                  txt1: "Flutter Task 1",
                  txt2: "10:00 Am: 11:00 Am",
                  widget: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 1.5,
                        color: AppColores.textColor,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "TODO",
                          style: getTesxtStyle(),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: AppColores.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
