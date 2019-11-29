import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenTest extends StatefulWidget {
  const HomeScreenTest({
    Key key,
    this.user,
  }) : super(key: key);
  final FirebaseUser user;

  @override
  HomeScreenTestState createState() => HomeScreenTestState();
}

class HomeScreenTestState extends State<HomeScreenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.email),
      ),
    );
  }
}
