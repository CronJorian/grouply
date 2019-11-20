import 'package:flutter/material.dart';

import 'colors.dart';
import 'views/login.dart';
import 'views/todo.dart';

class GrouplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: retroTheme,

      initialRoute: '/login',
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/todolist': (context) => TodoList(), 
      },
    );
  }
}