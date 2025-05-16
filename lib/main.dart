import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_app/local_db/class_db.dart';
import 'package:task_app/local_db/student_db.dart';
import 'package:task_app/local_db/teacher_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/provider/userdetails_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  hiveInit();

  runApp(Builder(builder: (context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TeacherNotifier>(
          create: (context) => TeacherNotifier(),
        ),
        ChangeNotifierProvider<UserdetailsNotifier>(
          create: (context) => UserdetailsNotifier(),
        ),
      ],
      child: const MyApp(),
    );
  }));
}

void hiveInit() async {
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TeacherHiveModelAdapter());
  Hive.registerAdapter(StudentHiveModelAdapter());
  Hive.registerAdapter(ClassHiveModelAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
