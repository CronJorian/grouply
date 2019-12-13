import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../activities/login.dart';
import '../notifiers/login_notifier.dart';
import '../task.dart';
import '../views/form_listview.dart';
import '../views/form_navigation.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key, this.list}) : super(key: key);
  final String list;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task(author: 'Max', text: 'Kuchen backen'),
    Task(author: 'Max', text: 'Milch einkaufen'),
  ];

  @override
  Widget build(BuildContext context) {
    final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Grouply"), centerTitle: true),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          UserAccountsDrawerHeader(

            accountName: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance.collection('users').document(loginNotifier.user?.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Loading username...');
                if (snapshot.hasError) return Text('Error beim laden des Benutzernamens');
                return Text(snapshot.data.exists ? snapshot.data['username'] : 'Fehler');
              }
            ),
            accountEmail: Text(loginNotifier.user?.email ?? "Keine E-Mail gefunden."),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("Max"),
            ),
          ),
          ListTile(
            title: Text("Example List"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Checklist(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Sommerreise"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Checklist(),
                ),
              );
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
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ]),
      ),
      body: Column(
        children: tasks.map((task) => TaskCard(task: task)).toList(),
        //children: _buildBody(context, loginNotifier.user.uid),
        //loginNotifier.isSignUp ? FormSignUp() : FormLogin()
      ),
    );
  }
}
