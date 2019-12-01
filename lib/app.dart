import 'package:flutter/material.dart';
import 'views/form_notifier.dart';
import 'package:provider/provider.dart';

import 'activities/home.dart';
import 'activities/login.dart';
import 'activities/todo.dart';
import 'colors.dart';

class GrouplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FormNotifier>.value(
          value: FormNotifier(),
        )
      ],
      child: MaterialApp(
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
          '/homeTest': (context) => HomeScreenTest(),
        },
      ),
    );
  }
}
