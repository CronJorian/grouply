import 'package:flutter/material.dart';

import '../colors.dart' as colors;
import '../views/form_navigation';
import '../task.dart';


class TaskList extends StatefulWidget{
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  List<Task> tasks = [
    Task(author:'Max', text:'Kuchen backen'),
    Task(author:'Max', text:'Milch einkaufen'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Grouply"),
          centerTitle: true
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Wähle eine Liste aus..."),
                accountEmail: Text("Oder erstelle eine neue Liste"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Text("Alpha"),
                ),
              ),
              ListTile(
                title: Text("Example List"),
              ),
            ]
        ),
      ),
      body: Column(
        children: tasks.map((task) => TaskCard(task: task)).toList(),
      ),
    );
  }
}
