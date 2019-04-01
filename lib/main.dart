import 'package:flutter/material.dart';
import 'package:flutter_assugnment_02/todo.dart';
import 'package:flutter_assugnment_02/addTask.dart';
import 'package:flutter_assugnment_02/object/todo.dart';

void main() => runApp(TodoApp());

String path = '/assets/eiei.db';
TodoProvider todoProvider = new TodoProvider();


class TodoApp extends StatelessWidget {

  Widget build(BuildContext context){

    todoProvider.open(path);

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