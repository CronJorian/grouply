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
        // create all routes here
        // either use the Navigator or the MaterialPageRoute
        // https://flutter.dev/docs/cookbook/navigation/navigation-basics
        // https://flutter.dev/docs/cookbook/navigation/named-routes
        // you don't need to fully read these, but make sure you understand how to navigate
        '/login': (context) => Login(),
        '/todolist': (context) => TodoList(), 
      },
    );
  }
}
