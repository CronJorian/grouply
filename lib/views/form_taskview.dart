import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import '../colors.dart' as colors;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    this.document,
  });
  final DocumentSnapshot document;

  @override
  _taskViewState createState() => _taskViewState();
}

class _taskViewState extends State<TaskView> {
  // * DateTimePicker
  static DateTime selectedDate = DateTime.now();

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 12),
      lastDate: DateTime(2025, 12),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // * Date Format
  formatDate(DateTime dateTime) {
    String forDate = DateFormat('dd.MM.yyyy').format(dateTime);
    return forDate;
  }

  final GlobalKey<FormState> _formTaskKey = GlobalKey<FormState>();
   Timestamp _endDate;
  @override
  Widget build(BuildContext document) {
    return Scaffold(
        backgroundColor: colors.primaryColor,
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Aufgabe'),
          actions: <Widget>[
            IconButton(
              alignment: Alignment(-1, 0),
              icon: Icon(
                Icons.share,
              ),
              color: Colors.white,
              onPressed: () {
                log('Test');
              },
            ),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('tasks')
              .document(widget.document.documentID)
              .snapshots(),
          builder: (context, snapshot) {
            final TextEditingController _descriptionController =
                TextEditingController();
            final TextEditingController _titleController =
                TextEditingController();
            final TextEditingController _costController =
                prefix0.TextEditingController();
                
            if (snapshot.hasData) {
              _descriptionController.text = snapshot.data["description"];
              _titleController.text = snapshot.data["title"];
              _costController.text = snapshot.data["totalCost"];
              _endDate = snapshot.data["endDate"];
            }
            /* _printLatestValue() {
           print("Second text field: ${_descriptionController.text}");
           
      }*/
            /*void initState(){
    super.initState();
    _descriptionController.addListener(_printLatestValue);
  }*/
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(3.0),
                    //key: _formTaskKey,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              'Titel:',
                              style: TextStyle(color: Colors.black),
                            ),
                            flex: 3),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              //color: Colors.grey,
                              height: 35.0,
                              child: TextField(
                                textAlign: TextAlign.left,
                                onSubmitted: (newValue) {
                                  print("-------------------------${newValue}");
                                  Firestore.instance
                                      .collection('tasks')
                                      .document(widget.document.documentID)
                                      .updateData(
                                    {'title': newValue},
                                  );
                                },
                                controller: _titleController,
                                decoration: InputDecoration(
                                    hintText: 'Füge einen Titel hinzu ...',
                                    hintStyle: TextStyle(
                                        color: colors.backgroundColor),
                                    border: InputBorder.none),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(3.0),
                    key: _formTaskKey,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              'Beschreibung:',
                              style: TextStyle(color: Colors.black),
                            ),
                            flex: 3),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              //color: Colors.grey,
                              height: 35.0,
                              child: TextField(
                                textAlign: TextAlign.left,
                                onSubmitted: (newValue) {
                                  print("-------------------------${newValue}");
                                  Firestore.instance
                                      .collection('tasks')
                                      .document(widget.document.documentID)
                                      .updateData(
                                    {'description': newValue},
                                  );
                                },
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                    hintText: 'Füge eine Beschreibung hinzu...',
                                    hintStyle: TextStyle(
                                        color: colors.backgroundColor),
                                    border: InputBorder.none),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(3.0),
                    //key: _formTaskKey,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              'Kosten:',
                              style: TextStyle(color: Colors.black),
                            ),
                            flex: 3),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              //color: Colors.grey,
                              height: 35.0,
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  //WhitelistingTextInputFormatter(RegExp("[0-9]*[,][0-9]*"))
                                ],
                                textAlign: TextAlign.left,
                                onSubmitted: (newValue) {
                                  print("-------------------------${newValue}");
                                  Firestore.instance
                                      .collection('tasks')
                                      .document(widget.document.documentID)
                                      .updateData(
                                    {'totalCost': newValue},
                                  );
                                },
                                controller: _costController,
                                decoration: InputDecoration(
                                    hintText: 'Füge Kosten hinzu ...',
                                    hintStyle: TextStyle(
                                        color: colors.backgroundColor),
                                    border: InputBorder.none),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(3.0),
                    //key: _formTaskKey,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              'Fertigstellung:',
                              style: TextStyle(color: Colors.black),
                            ),
                            flex: 0),
                        Expanded(
                          child: FlatButton(
                            //onPressed: () => _selectStartDate(context),
                            //child: Text(formatDate(selectedDate)),
                            // * SetState-Management: changing State within child
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 12),
                                maxTime: DateTime(2028, 12),
                                onChanged: (date) {
                                  //print('change $date');
                                },
                                onConfirm: (date) {
                                  print('confirm $date');
                                  setState(() {
                                    selectedDate = date;
                                  });
                                  Firestore.instance
                                      .collection('tasks')
                                      .document(widget.document.documentID)
                                      .updateData(
                                    {'endDate': selectedDate});
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.de,
                              );
                            },
                            textColor: Colors.black,
                            child: Text(
                             formatDate(_endDate)),

                            color: Colors.white,
                            //shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
        ));
  }
}