import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasktie/core/functions.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasktie/features/home/home_Screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  TextEditingController textController = TextEditingController();
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () async{
              if (key.currentState!.validate() && path!= null) {
                var box =await Hive.openBox('user');
                var userBox =Hive.box('user');
                userBox.put('name',textController.text);
                userBox.put('image',path);
                pushWithReplacement(context, HomeScreen(textController.text));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(child: Text("Erorr",style: getTitleTesxtStyle(),)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"))
                        ],
                        content: Text("something is wrong",style:getTesxtStyle()),
                      );
                    });
              }
            },
            child: Text(
              "Done",
              style: getTitleTesxtStyle(fontSize: 20),
            ))
      ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: path != null
                ? FileImage(File(path!))
                : NetworkImage("https://picsum.photos/200")
                    as ImageProvider<Object>,
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            txt: 'upload image',
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                if (photo != null) path = photo.path;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            txt: 'take a photo',
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.camera);
              setState(() {
                if (photo != null) path = photo.path;
              });
            },
          ),
          SizedBox(
            height: 70,
          ),
          Divider(
            thickness: 2.5,
            color: AppColores.primaryColor,
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: key,
              child: TextFormField(
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Value cannot be just spaces.";
                  }
                  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return "Only letters are allowed.";
                  }
                  if (value.length < 3) {
                    return "Please enter at least 3 letters.";
                  }
                  return null;
                },
                controller: textController,
                decoration: InputDecoration(
                    hintText: "Enter your name..",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColores.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(23)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColores.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(23))),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
