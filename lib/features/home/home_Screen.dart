import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasktie/core/functions.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_button.dart';
import 'package:tasktie/core/wigdets/custom_row.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:tasktie/core/wigdets/list_item.dart';
import 'package:tasktie/features/addTask/add_task_screen.dart';
import 'package:tasktie/features/completedTasks/completed_tasks_screen.dart';
import 'package:tasktie/features/profile/profile.dart';
import 'package:tasktie/features/upload/upload_screen.dart';

import '../../core/model/task_modek.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedValue = DateTime.now();
  Widget build(BuildContext context) {
    var userBox = Hive.box('user');
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomRow(
              txt1: "Hello,${userBox.get('name')}",
              txt2: "Have a Nice day!",
              widget: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pushTo(context, CompletedTasks());
                      },
                      icon: const Icon(Icons.add_task_outlined,
                          size: 35, color: AppColores.primaryColor)),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => pushTo(context, ProfileScreen()),
                    child: CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(File(userBox.get("image")))),
                  ),
                ],
              ),
            ),
          ),
          CustomRow(
              txt1: "${DateFormat("MMM,dd,yyyy").format(DateTime.now())}",
              txt2: "Today",
              widget: CustomButton(
                  txt: " + Add Task",
                  onPressed: () {
                    pushTo(context, const AddTaskScreen());
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
              child: ValueListenableBuilder(
                  valueListenable: Hive.box("task").listenable(),
                  builder: (context, value, child) {
                    var tasks = value.values.where(
                      (element) {
                        return (element.isComplete == false &&
                            element.date ==
                                DateFormat("dd/MM/yyyy").format(selectedValue));
                      },
                    ).toList();
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              if (direction != DismissDirection.startToEnd) {
                                tasks[index].isComplete = true;
                                value.put(tasks[index].id, tasks[index]);
                              } else {
                                value.delete(tasks[index].id);
                              }
                            },
                            background: Container(
                              decoration: BoxDecoration(
                                  color: AppColores.red,
                                  borderRadius: BorderRadius.circular(10)),
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              alignment: Alignment.centerLeft,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "delete",
                                  style: getTesxtStyle(),
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: AppColores.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: RotatedBox(
                                quarterTurns: -3,
                                child: Text(
                                  "Done",
                                  style: getTesxtStyle(),
                                ),
                              ),
                            ),
                            child: ListItem(
                              task: tasks[index],
                            ),
                          ),
                        );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
