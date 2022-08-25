import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/Pages/mainPage.dart';
import 'package:todo_list/Pages/vars.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoList');
  var localFile = Hive.box('todoList');
  tasks = localFile.get('tasks') ?? [];
  isChecked = localFile.get('checks') ?? [];
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}
