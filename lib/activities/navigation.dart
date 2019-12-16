import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../colors.dart' as c;
import '../notifiers/login_notifier.dart';
import 'form_listview.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @required
  Function callbackSetter;

  final TextEditingController _listController = TextEditingController();
  final GlobalKey<FormState> _formTextboxKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);

    return Drawer(
      // TODO: Handle invalid uid / no document found for specific user
      child: buildListView(loginNotifier, context),
    );
  }

  ListView buildListView(LoginNotifier loginNotifier, BuildContext context) {
    if (loginNotifier.user == null) return null;
    return ListView(children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(loginNotifier.user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading username...');
              if (snapshot.hasError) {
                return Text('Error beim laden des Benutzernamens.');
              }
              return Text(snapshot.data.exists
                  ? snapshot.data['username']
                  : 'Benutzername nicht gefunden.');
            }),
        accountEmail:
            Text(loginNotifier.user?.email ?? "Keine E-Mail gefunden."),
        currentAccountPicture: CircleAvatar(
          backgroundColor: c.cardColor,
        ),
      ),
      StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("listPermissions")
            .where("userID",
                isEqualTo: Firestore.instance
                    .collection('users')
                    .document(loginNotifier.user.uid))
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListTile(
                  title: StreamBuilder<DocumentSnapshot>(
                      stream:
                          snapshot.data.documents[index]["listID"].snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Text("Loading...");
                        return Text(snapshot.data["title"]);
                      }),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Checklist(snapshot.data.documents[index]["listID"]),
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
        title: Form(
          key: _formTextboxKey,
          child: TextFormField(
            decoration: InputDecoration(hintText: "create a new list name..."),
            keyboardType: TextInputType.text,
            controller: _listController,
            maxLines: 1,
            onEditingComplete: saveList,
            validator: (val) => val.isEmpty ? "Enter a listname" : null,
          ),
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
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        },
      ),
      Divider(),
    ]);
  }

  void saveList() async {
    final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);
    final formTextState = _formTextboxKey.currentState;
    final Firestore db = Firestore.instance;
    formTextState.save();
    if (formTextState.validate()) {
      try {
        await db.collection("lists").add(
          {
            'title': _listController.text,
            'uri': null,
          },
        ).then((result) async {
          await db.collection("listPermissions").add({
            'listID': result,
            'userID': Firestore.instance
                .collection('users')
                .document(loginNotifier.user.uid),
          });
        });
      } catch (e) {
        print(e);
      }
      _listController.clear();
    }
    initState();
  }

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }
}
