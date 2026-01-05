import 'package:flutter/material.dart';
import 'package:task_manager/basic_dismissible_example.dart';
import 'package:task_manager/basic_reorderable_example.dart';
import 'package:task_manager/dismissible_with_confirm.dart';
import 'package:task_manager/reorderable_builder_example.dart';
import 'package:task_manager/reorderable_dismissible.dart';
import 'package:task_manager/two_way_dismissible.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ReorderableDismissibleList(),
    );
  }
}
