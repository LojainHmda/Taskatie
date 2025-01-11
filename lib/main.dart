import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasktie/core/model/task_adapter.dart';
import 'package:tasktie/core/utils/colors.dart';

import 'features/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('user');
    await Hive.openBox('task');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: AppColores.primaryColor)),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
