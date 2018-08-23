  import 'package:flutter/material.dart';
import 'package:dalton_timer/pages/time_selection.dart';
void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Dalton Timer',
      theme:  ThemeData(primarySwatch: Colors.blueGrey,
      ),
      home:  TimeSelectionPage(),
    );
  }
}