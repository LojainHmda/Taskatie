import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/colors.dart';

TextStyle getTitleTesxtStyle({double? fontSize}){
return TextStyle(color: AppColores.primaryColor,fontSize:fontSize??40,fontWeight: FontWeight.bold);
}

TextStyle getTesxtStyle(){
return TextStyle(color: AppColores.textColor,fontSize:20,fontWeight: FontWeight.bold);
}
 
TextStyle getHintTesxtStyle(){
return TextStyle(color: AppColores.hintColor,fontSize:15);
}

TextStyle getCustomTesxtStyle({double? fontSize,Color? color}){
return TextStyle(color: color??AppColores.textColor,fontSize:fontSize??18,fontWeight: FontWeight.normal);
}


