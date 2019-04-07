import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


final String  tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnDone = "done";

class Todo{
  int id;
  String title;
  bool done;

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0,
    };
    if(id != null)  map[columnId] = id;
    return map;
  }

  Todo();

  Todo.fromMap(Map<String, dynamic> map){
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }

  @override
  String toString(){
    return "{Id: $id, Title: $title, Done: $done}";
  }
}

class TodoProvider{

  Database db;

  Future open(String path) async { 
    db = await openDatabase(path, version:1,
      onCreate: (Database db, int version) async{
        await db.execute("""
        create table $tableTodo(
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDone integer not null
        )
        """);
      });
  }


  Future<Todo> insert(Todo todo) async{
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }


  Future<List<Todo>> getTodo(bool isDone) async{
    await this.open("todo.db");
    List<Map> maps = await db.query(tableTodo,
      columns: [columnId, columnTitle, columnDone],
    );
    if(maps.length > 0){
      List<Todo> list = [];
      for (int i = 0; i < maps.length ; i++){
        Todo newData = await Todo.fromMap(maps[i]);
        if(newData.done == isDone)
          list.add(newData);
      }
      return list;
    }
    return null;
  }

  Future<int> delete() async{
    return await db.delete(tableTodo, where: "$columnDone = ?", whereArgs: [true]);
  }

  Future<int> update(Todo todo) async{
    return await db.update(tableTodo, todo.toMap(),
      where: "$columnId = ?", whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}


