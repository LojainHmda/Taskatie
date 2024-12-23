import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/colors.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            },
          ),
        ],
      )),
    );
  }
}
