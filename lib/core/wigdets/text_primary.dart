import 'package:flutter/material.dart';
import 'package:tasktie/core/utils/text_style.dart';

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
