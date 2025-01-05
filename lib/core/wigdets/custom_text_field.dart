
import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textController,
this.validation,
this.hintText,
this.max,
this.icon,
  });

  final TextEditingController textController;
  final String?Function(String?)? validation;
final String? hintText;
final int? max;
final IconButton? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      

      maxLines: max,
      validator: validation,
      controller: textController,
      decoration: InputDecoration(
        suffixIcon: icon,
          hintText:hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColores.primaryColor,
              ),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColores.primaryColor,
              ),
              borderRadius: BorderRadius.circular(20))),
    
    
    );
  }
}