import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../colors.dart' as colors;

class TaskView extends StatefulWidget {
  @override 
  _taskViewState createState() => _taskViewState();
}

class _taskViewState extends State<TaskView> {
  final textController = TextEditingController(
    text: "Test",
  );

  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: colors.primaryColor,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          'Aufgabe'
        ),
        actions: <Widget>[
          IconButton(
            alignment: Alignment(-1,0),
            icon: Icon(
              Icons.share,
            ),
            color: Colors.white,
            onPressed: () => {log('Test')},
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[


              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Beschreibung:', style: TextStyle(color: Colors.black)), flex: 0),
                      Expanded(child: 
                        EditableText(
                          backgroundCursorColor: Colors.black,
                          controller: TextEditingController(
                            text: 'Füge eine Beschreibung hinzu'
                          ),
                          cursorColor: Colors.black,
                          focusNode: FocusNode(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ),
                    ],
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Person:', style: TextStyle(color: Colors.black)), flex: 0),
                      Expanded(child: 
                        EditableText(
                          backgroundCursorColor: Colors.black,
                          controller: TextEditingController(
                            text: 'Teile eine Person ein'
                          ),
                          cursorColor: Colors.black,
                          focusNode: FocusNode(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ),
                    ],
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Startdatum:', style: TextStyle(color: Colors.black)), flex: 0),
                      Expanded(child: 
                        EditableText(
                          backgroundCursorColor: Colors.black,
                          controller: TextEditingController(
                            text: '12.12.2019'
                          ),
                          cursorColor: Colors.black,
                          focusNode: FocusNode(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ),
                    ],
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Enddatum:', style: TextStyle(color: Colors.black)), flex: 0),
                      Expanded(child: 
                        EditableText(
                          backgroundCursorColor: Colors.black,
                          controller: TextEditingController(
                            text: '16.12.2019'
                          ),
                          cursorColor: Colors.black,
                          focusNode: FocusNode(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ),
                    ],
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Kosten:', style: TextStyle(color: Colors.black)), flex: 0),
                      Expanded(child: 
                        EditableText(
                          backgroundCursorColor: Colors.black,
                          controller: TextEditingController(
                            text: '€€€'
                          ),
                          cursorColor: Colors.black,
                          focusNode: FocusNode(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ),
                    ],
                  )
              )
            ],
          )
        )
      )
    );
  }
}