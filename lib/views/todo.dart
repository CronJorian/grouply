import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Go back!"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
