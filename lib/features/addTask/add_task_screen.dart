import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Text",
          style: getCustomTesxtStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextPrimary(txt: "Title"),
          CustomTextFormField(textController: titleController),
          TextPrimary(txt: "Note"),
          CustomTextFormField(
            textController: noteController,
            max: 5,
          ),
          TextPrimary(txt: "Date"),
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
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColores.primaryColor,
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextPrimary(txt: "Start Time"),
                    CustomTextFormField(textController: startController)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TextPrimary(txt: "End Time"),
                    CustomTextFormField(textController: endController)
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class TextPrimary extends StatelessWidget {
  const TextPrimary({
    super.key,
    required this.txt,
  });
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(txt, style: getTitleTesxtStyle(fontSize: 23)),
    );
  }
}
