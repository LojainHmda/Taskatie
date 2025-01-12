import 'package:flutter/material.dart';
import 'package:tasktie/core/model/task_modek.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_row.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.task,
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
          color: task.color == 0
              ? AppColores.primaryColor
              : task.color == 1
                  ? AppColores.yellow
                  : task.color == 2
                      ? AppColores.red
                      : AppColores.green,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
