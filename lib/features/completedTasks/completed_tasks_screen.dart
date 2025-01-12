import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasktie/core/wigdets/list_item.dart';

class CompletedTasks extends StatefulWidget {
  CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  var taskBox = Hive.box('task');

  @override
  Widget build(BuildContext context) {
    var tasks = taskBox.values
        .where(
          (element) => element.isComplete == true,
        )
        .toList();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 10,),
                  ListItem(task: tasks[index]),
                ],
              );
            },
          )),
    );
  }
}
