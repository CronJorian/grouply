import 'package:flutter/material.dart';
import 'package:grouply/notifiers/login_notifier.dart';
import 'package:provider/provider.dart';

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
    final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        // If no user is logged is provided there will be no information.
        title: Text(loginNotifier.user?.email ?? "Kein User ist angemeldet."),
      ),
    );
  }
}
