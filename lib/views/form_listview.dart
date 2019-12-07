import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouply/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTileCheckbox extends StatefulWidget {
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
  final db = Firestore.instance;

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
        padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
        decoration: myBoxDecoration(),
        child: Row(
          children: <Widget>[
            Container(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: primaryColor),
                child: Checkbox(
                    activeColor: primaryColor,
                    value: document['complete'],
                    onChanged: (bool newValue) => widget.onChanged(newValue)),
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
        body: StreamBuilder(
            stream: Firestore.instance.collection('tasks').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('loading...');
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    buildListItem(context, snapshot.data.documents[index]),
              );
            }),
        bottomSheet: Container(
          decoration: myBoxDecoration(),
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: Row(children: <Widget>[
            Flexible(
                child: TextFormField(
              style: TextStyle(
                color: primaryColor,
              ),
              key: _formTextboxKey,
              decoration: const InputDecoration(
                  hintText: 'Erstelle eine neue Aufgabe...',
                  hintStyle: TextStyle(color: primaryColor)),
              validator: (val) =>
                  val.isEmpty ? 'Bitte trage hier den Titel ein!' : null,
              //onSaved:
            )),
          ]),
          margin: EdgeInsets.all(8.0),
        ));
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

/*
          Firestore.instance.runTransaction((transaction) async {
                await transaction.set(Firestore.instance.collection("tasks").document(), {
                  'reply' : {
                  'title': _title,
                  'description': '',
                  'complete': false,
    }*/
