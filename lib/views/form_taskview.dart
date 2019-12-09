import 'dart:developer';
import 'package:flutter/material.dart';
import '../colors.dart' as colors;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class TaskView extends StatefulWidget {
  @override 
  _taskViewState createState() => _taskViewState();
}

// final mainReference = FirebaseDatabase.instance.reference();

class _taskViewState extends State<TaskView> {

  final textController = TextEditingController(
    text: "Test",
  );
  final GlobalKey<FormState> _formTaskKey = GlobalKey<FormState>();

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
                  key: _formTaskKey,
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
                  //key: _formTaskKey,
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
                  //key: _formTaskKey,
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
                  //key: _formTaskKey,
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
                  //key: _formTaskKey,
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

  void saveTask() async {
    final formTextState = _formTaskKey.currentState;
    final Firestore db = Firestore.instance;
    formTextState.save();
    if (formTextState.validate()) {
      try {
        await db.collection("tasks").add(
          {
            'title': '',
            'description': '',
            'person': '',
            'start-date': '',
            'end-date': '',
            'costs': '',
            'complete': false,
            // ID?
          },
        );
      } catch (e) {
        print(e.message);
      }
    }
    initState();
  }

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
   }

  void changeStatus() async {
    final Firestore db = Firestore.instance;
  }
}