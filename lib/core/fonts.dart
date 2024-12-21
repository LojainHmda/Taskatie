import 'package:flutter/material.dart';

import 'colores.dart';

class CustomTextStyle extends StatelessWidget {
  String text;
  Color? color;
  double? size;
   CustomTextStyle({
    Key? key,
    required this.text,
     this.color,
     this.size,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle( color: color ?? Colors.black,fontSize: size??14));
  }

}
