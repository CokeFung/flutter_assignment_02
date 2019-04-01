import 'package:flutter/material.dart';
import 'package:flutter_assugnment_02/main.dart';
import 'package:flutter_assugnment_02/object/todo.dart';
class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new TodoScreenState();
  }
}


class TodoScreenState extends State<TodoScreen>{
  Widget build(BuildContext context){



    List<Widget> _GetTask(){
      Todo temp = new Todo();
      temp.name = 'AAAAAAA';
      temp.isDone =false;
      todoProvider.insert(temp);

      var a = todoProvider.getTodo(0);
      return [
        ListTile(
          title: Text(a.toString()),
        )
      ];
    }

    void _DeleteTask(){}

    //Task App Bar
    Row taskAppBar = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Todo'),
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: (){
            Navigator.pushNamed(context, '/addTask');
          },
        ),
      ],
    );

    //Completed App Bar
    Row comAppBar = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Completed'),
        IconButton(
          icon: Icon(Icons.delete),
          color: Colors.white,
          onPressed: (){
            _DeleteTask();
          },
        ),
      ],
    );

    //Task bottom tab
    Tab taskBottomTab = new Tab(
      icon: Icon(Icons.list),
      text: 'Task',
    );

    //Completed bottom tab
    Tab comBottomTab = new Tab(
      icon: Icon(Icons.done_all),
      text: 'Completed',
    );

    //Task List
    Container taskList = new Container(
      child: Card(
        child: Column(
          children: _GetTask(),
        ),
      ),
    );

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.redAccent,
          title: TabBarView(
            children: <Widget>[taskAppBar, comAppBar],
          ),
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.redAccent,
          labelColor: Colors.redAccent,
          tabs: <Widget>[taskBottomTab, comBottomTab],
        ),
        body: TabBarView(
          children: <Widget>[
            taskList,
            Container(
              child: Center(child: Text("Completed"),),
            ),
          ],
        ),
      ),
    );
    
  }
}