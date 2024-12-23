import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/text_style.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
 final double width;
  final double height;
  final Color bgColor;
  final String txt;
    final Color txtColor;
final Function() onPressed;
   CustomButton({
    super.key,  this.width=250,  this.height=40,  this.bgColor = AppColores.primaryColor ,  this.txtColor = AppColores.textColor, required this.txt, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width:width ,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(txt, style: getCustomTesxtStyle()),
            style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))));
  }
}
