import 'package:flutter/material.dart';
import 'package:grouply/colors.dart';

class Tasklist extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

class ListTileCheckbox extends StatelessWidget {
  const ListTileCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
          // decoration: myBoxDecoration(),
          child: Row(
            children: <Widget>[
              Container(
                child: Checkbox(
                    activeColor: primaryColor,
                    value: value,
                    onChanged: (bool newValue) => onChanged(newValue)),
              ),
              Expanded(
                child: ListTile(
                    title: value
                        ? Text('Two-Line-Item',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: primaryColor,
                            ))
                        : Text(
                            'Two-Line-Item',
                            style: TextStyle(color: primaryColor),
                          ),
                    subtitle: value
                        ? Text(
                            'Here is a second line',
                            style: TextStyle(color: primaryColor),
                          )
                        : Text(
                            'Here is a second line',
                            style: TextStyle(color: primaryColor),
                          ),
                    trailing: Icon(Icons.insert_emoticon),
                    onTap: () {} //Aufruf der Detailansicht.
                    ),
              ),
            ],
          ),
        ));
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
      border: Border.all(
        color: primaryColor,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)));
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<bool> inputs = List<bool>();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < 20; i++) {
        inputs.add(true);
      }
    });
  }

  void itemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: inputs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: cardColor,
                child: Column(
                  children: <Widget>[
                    ListTileCheckbox(
                      value: inputs[index],
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      onChanged: (bool val) {
                        itemChange(val, index);
                      },
                    ),
                  ],
                ),
              );
            }),
        bottomSheet: Container(
          padding: EdgeInsets.all(7.0),
          child: Row(children: <Widget>[
            Flexible(
              child: TextFormField(
                  decoration: const InputDecoration(
                hintText: 'Erstelle eine neue Aufgabe...',
              )),
            ),
          ]),
          margin: EdgeInsets.all(8.0),
        ));
  }
}
