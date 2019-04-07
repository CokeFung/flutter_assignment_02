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
                      onChanged: (bool done){
                        setState(() { allTask[ind].done = true;});
                        todo.update(allTask[ind]);
                        setState(() {});
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
            Center(child: Text('Conmpleteterefr')),
          ],
        ) 
      ),
    );
    
  }
}

/*
class TodoScreen extends StatelessWidget {
  TodoProvider todo = TodoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Screen"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Open DB"),
            onPressed: () {
              todo.open("todo.db");
            },
          ),
          RaisedButton(
            child: Text("Insert"),
            onPressed: () async {
              Todo data = Todo();
              data.title = "test";
              data.done = false;
              Todo result = await todo.insert(data);
              print(result.title);
              // todo.insert(data).then((result){

              // });
            },
          ),
          RaisedButton(
            child: Text("Get"),
            onPressed: () async {
              List<Todo> data = await todo.getTodo(false);
              for(int i =0; i< data.length;i++) print(data[i].toString());
            },
          ),
          RaisedButton(
            child: Text("Update"),
            onPressed: () async {
              Todo newData = Todo();
              newData.id = 1;
              newData.title = 'New Test';
              newData.done = true;

              int result = await todo.update(newData);
              print(result);
            },
          ),
          RaisedButton(
            child: Text("delete"),
            onPressed: () async {
              int result = await todo.delete(1);
              print(result);
            },
          ),
          RaisedButton(
            child: Text("Close DB"),
            onPressed: () {
             todo.close();
            },
          ),
        ],
      ),
    );
  }
}

*/