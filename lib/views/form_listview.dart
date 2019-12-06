import 'package:flutter/material.dart';
import 'package:grouply/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ListTileCheckbox extends StatelessWidget {
  const ListTileCheckbox({
    this.label,
    this.padding,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final Function onChanged;

  @override
  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    
    return Scaffold(
          body: Container(
        // decoration: myBoxDecoration(),
        child: Row(
          children: <Widget>[
            Container(
              child: Checkbox(
                  activeColor: primaryColor,
                  value: document['complete'],
                  onChanged: (bool newValue) => onChanged(newValue)),
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
                  trailing: Icon(Icons.insert_emoticon),
                  onTap: () {} //Aufruf der Detailansicht.
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
      body: StreamBuilder(
          stream: Firestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading...');
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => buildListItem(
                  context,
                  snapshot.data.documents[
                      index]), /*{
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: cardColor,
                  child: Column(
                    children: <Widget>[
                      ListTileCheckbox(
                        value: inputs[index],
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        onChanged: (bool val) {
                          itemChange(val, index);
                        },
                      ),
                    ],
                  ),
                );
              });*/
            );
          }),
    );
  }
}