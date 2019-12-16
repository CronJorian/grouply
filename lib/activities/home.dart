import 'package:flutter/material.dart';

import '../activities/navigation.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Uses a "globally" defined object (in app.dart) and can react on changes
    // This is a lot easier/cleaner than passing variables as an argument,
    // if you need them more often or in deeper nested children
    return Scaffold(
      appBar: AppBar(),
      drawer: TaskList(),
    );
  }
}
