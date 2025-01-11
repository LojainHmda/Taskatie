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
import 'package:tasktie/features/addTask/add_task_screen.dart';
import 'package:tasktie/features/upload/upload_screen.dart';

import '../../core/model/task_modek.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late var selectedValue;
    var box= Hive.box('task');
  Widget build(BuildContext context) {
    var userBox = Hive.box('user');
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomRow(
              txt1: "Hello,${userBox.get('name')}",
              txt2: "Have a Nice day!",
              widget: CircleAvatar(
                  radius: 40,
                  backgroundImage: FileImage(File(userBox.get("image")))),
            ),
          ),
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
              child: ValueListenableBuilder(
                valueListenable: Hive.box("task").listenable(),
                builder: (context, value, child) {
                  var tasks =value.values.toList();
               return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      if(direction != DismissDirection.startToEnd){
                        tasks[index].iscomplet=true;
                         tasks[index].color=3;
                      }
                      else{
                        value.deleteAt(index);
                      }
                      
                    },
                    background: Container(
                      decoration: BoxDecoration(
                          color: AppColores.red,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(left: 15, right: 15),
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
                      padding: EdgeInsets.only(left: 15, right: 15),
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
                    child: ListItem(task: tasks[index],),
                  ),
                );
                            },
                          );}
              ))
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this .task,
  });
 
final Task task;
  @override
  Widget build(BuildContext context) {
    return CustomRow(
      icon: Icon(Icons.watch_later_outlined),
      txt1: task.title,
      txt2: "${task.startTime} to ${task.endTime}",
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
          color: task.color==0? AppColores.primaryColor :task.color==1?AppColores.yellow:task.color==2? AppColores.red:AppColores.green,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
