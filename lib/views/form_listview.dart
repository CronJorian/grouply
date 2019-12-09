import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:grouply/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTileCheckbox extends StatefulWidget {
  // const ListTileCheckbox({
  //   Key key,
  // }) : super(key: key);

  const ListTileCheckbox({
    this.label,
    this.padding,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final ValueChanged<bool> onChanged;

  @override
  _ListTileCheckboxState createState() => _ListTileCheckboxState();
}

class _ListTileCheckboxState extends State<ListTileCheckbox> {
  final GlobalKey<FormState> _formTextboxKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    return Scaffold(
      body: Container(
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
                    onChanged: (bool newValue) => changeStatus(document)),
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
                  subtitle: document['complete']
                      ? Text(
                          document['description'],
                          style: TextStyle(color: primaryColor),
                        )
                      : Text(
                          document['description'],
                          style: TextStyle(color: primaryColor),
                        ),
                  trailing: IconButton(
                    icon: Icon(Icons.insert_emoticon),
                    color: primaryColor,
                    iconSize: 35.0,
                    onPressed: () => {}, // TODO: Personenauswahl
                  ),
                  onTap: () {} // TODO: Aufruf der Detailansicht.
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () => {},
        ),
        // TODO: Listenname dynamisch machen
        title: Text("Listenname"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => {}, // TODO: Liste teilen
          ),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice,
                        style: TextStyle(
                          color: primaryColor,
                        )));
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return Scrollbar(
                  child: ListView.builder(
                    itemExtent: 84.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return buildListItem(
                          context, snapshot.data.documents[index]);
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
                      hintStyle: TextStyle(color: primaryColor)),
                ),
              ),
            ),
            margin: EdgeInsets.all(8.0),
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
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
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
            //'listid': _listcontroller  // TODO: ListenID muss hier immer mitgegeben werden!
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
    db
        .collection('tasks')
        .document(document.documentID)
        .updateData({'complete': !document['complete']});
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
