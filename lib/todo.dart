import 'package:flutter/material.dart';
import 'package:flutter_assugnment_02/object/Database.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new TodoScreenState();
  }
}


class TodoScreenState extends State<TodoScreen>{
  
  TodoProvider todo = TodoProvider();

  Widget build(BuildContext context){
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
            setState(() async{
              await todo.delete();
              await todo.open("todo.db");
            });
            
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
    List<Todo> allTask;
    Container taskList = new Container(
      child: FutureBuilder(
        future: todo.getTodo(false),
        builder: (BuildContext context, AsyncSnapshot <List<Todo>> snapshot){
          allTask = [];
          if(snapshot.hasData){
            for (var i in snapshot.data) allTask.add(i);
          }
          return allTask.length == 0 ? Center(child:Text("No subject")): ListView.builder(
            itemCount: allTask.length,
            itemBuilder: (BuildContext context, int ind){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: new Text(allTask[ind].title),
                    trailing: Checkbox(
                      value: allTask[ind].done,
                      onChanged: (bool isCheck) async {
                        setState(() { allTask[ind].done = isCheck;});
                        todo.update(allTask[ind]);
                        todo.open("todo.db");
                      },
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );

    //Task List
    Container doneList = new Container(
      child: FutureBuilder(
        future: todo.getTodo(true),
        builder: (BuildContext context, AsyncSnapshot <List<Todo>> snapshot){
          allTask = [];
          if(snapshot.hasData){
            for (var i in snapshot.data) allTask.add(i);
          }
          return allTask.length == 0 ? Center(child:Text("No subject")): ListView.builder(
            itemCount: allTask.length,
            itemBuilder: (BuildContext context, int ind){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: new Text(allTask[ind].title),
                    trailing: Checkbox(
                      value: allTask[ind].done,
                      onChanged: (bool isCheck) async {
                        setState(() { allTask[ind].done = isCheck;});
                        todo.update(allTask[ind]);
                        todo.open("todo.db");
                      },
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );


    void updateDB(int n){
      setState(() {
        todo.open("todo.db");
      });
    }
    
    return DefaultTabController(
      length: 2,
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
          onTap: updateDB,
        ),
        body: TabBarView(
          children: <Widget>[
            taskList,
            doneList,
          ],
        ) 
      ),
    );
    
  }
}

