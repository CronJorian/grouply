import 'package:flutter/material.dart';
import 'package:grouply/views/form_listview.dart';
import 'package:grouply/views/form_login.dart';

import '../colors.dart' as colors;
import '../views/form_navigation.dart';
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

  String _user;
  String _list;

  @override
  Widget build(BuildContext context) {
    //final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);
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
                  backgroundColor: Colors.white,
                  child: Text("Max"),
                ),
              ),
              ListTile(
                title: Text("Example List"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListTileCheckbox()));
                },
              ),
              ListTile(
                title: Text("Sommerreise"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListTileCheckbox()));
                },
              ),
              Divider(),
              ListTile(
                title: Text("close"),
                trailing: Icon(Icons.close),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("log out"),
                trailing: Icon(Icons.power_settings_new),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormLogin()));
                },
              ),
            ]
        ),
      ),
      body: Column(
        children: tasks.map((task) => TaskCard(task: task)).toList(),
        //children: _buildBody(context, loginNotifier.user.uid),
      ),
    );
  }
}
