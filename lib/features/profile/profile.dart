import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_text_field.dart';

import '../../core/wigdets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userBox = Hive.box('user');
  String? path;
  TextEditingController textController = TextEditingController();
  var key = GlobalKey<FormState>();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              CircleAvatar(
                  backgroundImage: FileImage(File(userBox.get("image"))),
                  radius: 100,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.edit, size: 40),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("ok"))
                                ],
                                content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        width: 110,
                                        height: 100,
                                        txt: 'upload image',
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? photo =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            if (photo != null) {
                                              path = photo.path;
                                              userBox.put('image', path);
                                            }
                                            ;
                                          });
                                        },
                                      ),
                                      CustomButton(
                                        width: 110,
                                        height: 100,
                                        txt: 'take a photo',
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? photo =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          setState(() {
                                            if (photo != null) {
                                              path = photo.path;
                                              userBox.put('image', path);
                                            }
                                          });
                                        },
                                      ),
                                    ]));
                          },
                        );
                      },
                      style: IconButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 203, 197, 197),
                          foregroundColor: AppColores.textColor),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              Text(
                userBox.get('name'),
                style: getTitleTesxtStyle(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: isVisible
                    ? Form(
                        key: key,
                        child: CustomTextFormField(
                          textController: textController,
                          hintText: userBox.get('name'),
                        ),
                      )
                    : const SizedBox(),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
          
                  if (key.currentState != null && key.currentState!.validate()) {
                    userBox.put('name', textController.text);
                  }
                },
                child: Text(isVisible ? "save" : "Change the name"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
