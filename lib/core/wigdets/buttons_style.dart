import 'package:flutter/material.dart';

import '../utils/colors.dart';

primaryButtonStyle(){
  return ElevatedButton.styleFrom(backgroundColor: AppColores.primaryColor,shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10)));
}