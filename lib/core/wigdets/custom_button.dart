import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/text_style.dart';
import 'package:tasktie/core/wigdets/buttons_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:40,width: 160,child: ElevatedButton(onPressed: (){}, child: Text("upload image",style:getCustomTesxtStyle()),style: primaryButtonStyle(),));
  }
}