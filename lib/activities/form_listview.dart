import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouply/activities/navigation.dart';

import '../colors.dart';

class Checklist extends StatefulWidget {
  const Checklist({
    this.listID,
    this.title,
  });

  final DocumentReference listID;
  final DocumentReference title;

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final GlobalKey<FormState> _formTextboxKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
            .collection('lists').document(this.widget.listID.documentID).snapshots(),
          builder: (context, snapshot){
            return Text(snapshot.data["title"] ?? "Listenname");    
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => {}, // TODO: Liste teilen
          ),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map(
                (String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  );
                },
              ).toList();
            },
          ),
        ],
      ),
      drawer: TaskList(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('tasks')
                  .where('listID', isEqualTo: this.widget.listID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(),
                  );
                }
                return Scrollbar(
                  child: ListView.builder(
                    itemExtent: 84.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return buildListItem(
                        context,
                        snapshot.data.documents[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: myBoxDecoration(),
            padding: EdgeInsets.only(left: 16.0),
            child: Container(
              child: Form(
                key: _formTextboxKey,
                child: TextFormField(
                  controller: _titleController,
                  onEditingComplete: saveTitle,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: primaryColor,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Erstelle eine neue Aufgabe...',
                    hintStyle: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.only(left: 12.0),
      decoration: myBoxDecoration(),
      child: Row(
        children: <Widget>[
          Container(
            child: Theme(
              data: ThemeData(unselectedWidgetColor: primaryColor),
              child: Checkbox(
                activeColor: primaryColor,
                value: document['complete'],
                onChanged: (v) => changeStatus(document),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
                title: document['complete']
                    ? Text(document['title'],
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: primaryColor,
                        ))
                    : Text(
                        document['title'],
                        style: TextStyle(color: primaryColor),
                      ),
                subtitle: Text(
                  document['description'],
                  style: TextStyle(color: backgroundColor),
                ),
                trailing: IconButton(
                  tooltip: "Eine Person zuweisen.",
                  icon: Icon(
                      Icons.insert_emoticon), // TODO: Add variable UserIcon
                  color: primaryColor,
                  iconSize: 35.0,
                  onPressed: () => {}, // TODO: Personenauswahl
                ),
                onTap: () {} // TODO: Aufruf der Detailansicht.
                ),
          ),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    print('Verlinkung einfügen'); // TODO: Verlinkung zu Menüpunkten
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: cardColor,
      border: Border.all(
        width: 2.5,
        color: primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    );
  }

  void saveTitle() async {
    final formTextState = _formTextboxKey.currentState;
    final Firestore db = Firestore.instance;
    formTextState.save();
    if (formTextState.validate()) {
      try {
        await db.collection("tasks").add(
          {
            'title': _titleController.text,
            'description': '',
            'complete': false,
            'listID': this
                .widget
                .listID 
          },
        );
      } catch (e) {
        print(e.message);
      }
      _titleController.clear();
    }
    initState();
  }

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  void changeStatus(DocumentSnapshot document) {
    final Firestore db = Firestore.instance;
    db.collection('tasks').document(document.documentID).updateData(
      {
        'complete': !document['complete'],
      },
    );
  }
}

class Constants {
  static const String Einstellungen = 'Einstellungen';
  static const String Drucken = 'Liste drucken';
  static const String Freunde = 'App empfehlen';
  static const String Loeschen = 'Liste löschen';

  static const List<String> choices = <String>[
    Einstellungen,
    Drucken,
    Freunde,
    Loeschen,
  ];
}
