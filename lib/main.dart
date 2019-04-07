import 'package:flutter/material.dart';
import 'package:flutter_assugnment_02/todo.dart';
import 'package:flutter_assugnment_02/addTask.dart';
import 'package:flutter_assugnment_02/object/Database.dart';

void main() => runApp(TodoApp());


class TodoApp extends StatelessWidget {
  
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new TodoScreen(),
        '/todo': (BuildContext context) => new TodoScreen(),
        '/addTask': (BuildContext context) => new AddTaskScreen(),
      },
    );
  }
}