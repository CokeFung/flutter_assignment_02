import 'package:flutter/material.dart';
import 'package:flutter_assugnment_02/main.dart';
import 'package:flutter_assugnment_02/object/Database.dart';
class AddTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new AddTaskScreenState();
  }
}

class AddTaskScreenState extends State<AddTaskScreen> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _subjectName = '';
  
  TodoProvider todo = new TodoProvider();


  Widget build(BuildContext context){
    //Text field of subject
    TextFormField subject = new TextFormField(
      decoration: const InputDecoration(
        labelText: 'Subject',
      ),
      onSaved: (v) => _subjectName = v,
      validator: (subjectName){
        if (subjectName.isEmpty)
          return 'Please fill subject';
        else
          _subjectName = subjectName;
      },
    );

    //validate function
    
    void _ValidateInput(){
      _formKey.currentState.validate();
      if (_subjectName.isEmpty){
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: new Text('Please fill subject'),
          ),
        );
      }
      else{
        todo.open("todo.db");
        Todo temp = new Todo();
        temp.title = _subjectName;
        temp.done = false;
        todo.insert(temp);
        print("Added");
        Navigator.of(context).pop();
      }
    }

    //save button
    RaisedButton saveButton = new RaisedButton(
      child: Text('Save'),
      color: Colors.lightGreen,
      textColor: Colors.white,
      onPressed: _ValidateInput,
    );
  
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("New Subject"),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            children: <Widget>[
              subject,
              saveButton,
            ],
          ),
        ),
      ),
    );
  }
}