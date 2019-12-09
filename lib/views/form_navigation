import 'package:flutter/material.dart';
import 'package:grouply/activities/home.dart';
import 'package:pedantic/pedantic.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../colors.dart' as colors;
import '../task.dart';

class TaskCard extends StatelessWidget {

  final Task task;
  TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                task.text,
                style: TextStyle(
                  fontSize: 16,
                  color: colors.backgroundColor,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                task.author,
                style: TextStyle(
                  fontSize: 16,
                  color: colors.backgroundColor,
                ),
              )
            ]
        ),
      ),
    );
  }
}
