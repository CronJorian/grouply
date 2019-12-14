import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouply/colors.dart' as c;
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
    const String myuserid = "ErDtqhy205Pe1X3QhxUXkVulYNz2";
    return Scaffold(
      appBar: AppBar(title: Text("Grouply"), centerTitle: true),
      drawer: Drawer(
        // TODO: Handle invalid uid / no document found for specific user
        child: ListView(children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('users')
                // TODO: Change back
                //  .document(loginNotifier.user?.uid)
                 .document(myuserid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text('Loading username...');
                  if (snapshot.hasError) {
                    return Text('Error beim laden des Benutzernamens');
                  }
                  return Text(snapshot.data.exists
                      ? snapshot.data['username']
                      : 'Fehler');
                }),
            accountEmail:
            // TODO: Change back
//                Text(loginNotifier.user?.email ?? "Keine E-Mail gefunden."),
            Text("Keine E-Mail gefunden."),

            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            // TODO: Change back
            // stream: Firestore.instance.collection("listPermissions").where("userID", isEqualTo: Firestore.instance.collection('users').document(loginNotifier.user.uid)).snapshots(),
            stream: Firestore.instance.collection("listPermissions").where("userID", isEqualTo: Firestore.instance.collection('users').document(myuserid)).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if(!snapshot.hasData) return CircularProgressIndicator();
                  return ListTile(
                      title: StreamBuilder<DocumentSnapshot>(
                          stream: snapshot.data.documents[index]["listID"]
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Text("Loading...");
                            return Text(snapshot.data["title"]);
                          }
                      ),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checklist(),
                          ),
                        );
                      });
                },
              );
            },
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.add),
            title: TextFormField(
              decoration: InputDecoration(labelText: "create a new list..."),
              keyboardType: TextInputType.text,
              maxLines: 1,
              validator: (val) => val.isEmpty ? "Enter a listname" : null,
                onChanged: (val){
                //setState(() => 'lists' = val);
                },
                onSaved: (String listname) {
                  final listname = Firestore.instance;
                }
            ),
          ),
          Divider(),
          ListTile(
            title: Text("close"),
            trailing: Icon(Icons.close),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text("log out"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              loginNotifier.logOut();
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },

          ),
          Divider(),
        ]),
      ),
      body: Column(
        children: tasks.map((task) => TaskCard(task: task)).toList(),
        //children: _buildBody(context, loginNotifier.user.uid),
        //loginNotifier.isSignUp ? FormSignUp() : FormLogin(),
      ),
    );
  }
}
