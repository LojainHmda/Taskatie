import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tasktie/core/functions.dart';
import 'package:tasktie/core/model/task_modek.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_button.dart';
import 'package:tasktie/core/wigdets/custom_text_field.dart';
import 'package:tasktie/core/wigdets/text_primary.dart';
import 'package:tasktie/features/home/home_Screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var selectNumber = 0;
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  TextEditingController startController =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  TextEditingController endController =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Text",
          style: getCustomTesxtStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TextPrimary(txt: "Title"),
              CustomTextFormField(
                  textController: titleController,
                  validation: (value) {
                    if (value != null) {
                      if (value.length < 5) {
                        return "the title is too short";
                      }
                      return null;
                    }
                    ;
                  }),
              const TextPrimary(txt: "Note"),
              CustomTextFormField(
                textController: noteController,
                max: 5,
                validation: (value) {
                  if (value != null) {
                    if (value.length < 5) {
                      return "the title is too short";
                    }
                    return null;
                  }
                  ;
                },
              ),
              const TextPrimary(txt: "Date"),
              CustomTextFormField(
                  textController: dateController,
                  icon: IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2026),
                        ).then((value) {
                          if (value == null) {
                          } else {
                            dateController.text =
                                DateFormat("dd/MM/yyyy").format(value);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColores.primaryColor,
                      ))),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const TextPrimary(txt: "Start Time"),
                        CustomTextFormField(
                          readonly: true,
                          textController: startController,
                          validation: (time) {
                            if (time != null) {
                              var start = DateFormat("dd/MM/yyyy hh:mm a")
                                  .parse("${dateController.text} $time");
                              if (start.compareTo(DateTime.now()) < 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Start time must be after the current time!"),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                return "invalid";
                              }
                            }
                            return null;
                          },
                          icon: IconButton(
                              onPressed: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  if (value != null) {
                                    startController.text =
                                        value.format(context);
                                  }
                                });
                              },
                              icon: const Icon(Icons.access_time)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      const TextPrimary(txt: "End Time"),
                      CustomTextFormField(
                          readonly: true,
                          textController: endController,
                          validation: (time) {
                            if (time != null) {
                              var end = DateFormat("dd/MM/yyyy hh:mm a")
                                  .parse("${dateController.text} $time");
                              var start = DateFormat("dd/MM/yyyy hh:mm a")
                                  .parse("${dateController.text} ${startController.text}");

                              if (end.compareTo(start) <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "End time must be after start time!"),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                                                return "invalid";

                              }
                            }
                            return null;
                          },
                          icon: IconButton(
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    endController.text = value.format(context);
                                  }
                                });
                              },
                              icon: const Icon(Icons.access_time)))
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(3, (index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: index == 0
                                ? AppColores.primaryColor
                                : index == 1
                                    ? AppColores.yellow
                                    : AppColores.red,
                            child: index == selectNumber
                                ? const Icon(Icons.check)
                                : const SizedBox(),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectNumber = index;
                          });
                        },
                      );
                    }),
                  ),
                  const Spacer(),
                  CustomButton(
                      txt: "Create Task",
                      width: 170,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Task newTask = Task(
                              title: titleController.text,
                              id: DateTime.now().toString() +
                                  titleController.text,
                              note: noteController.text,
                              startTime: startController.text,
                              endTime: endController.text,
                              date: dateController.text,
                              isComplete: false,
                              color: selectNumber);
                          var taskBox = Hive.box('task');
                          taskBox.put(newTask.id, newTask);
                          pushWithReplacement(context, HomeScreen());
                        }
                      }),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
