import 'dart:math';

import 'package:dalton_timer/timer.dart';
import 'package:dalton_timer/widgets/timerface.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key key,
  }) : super(key: key);

  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  String _minutesText;
  void _onDurationSelected(Color color, Duration duration) {
    print("duration selected $duration");
    Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => TimerPage(
                timerColor: color,
                initialDuration: duration,
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<State<TextField>> timeInput = GlobalKey();
    _minutesText = null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick time"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timelapse),
            onPressed: () {
               showModalBottomSheet<Duration>(context: context,
               builder: (BuildContext c) => Container(
                 padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(hintText: "Enter time in minutes",),
                       keyboardType: TextInputType.numberWithOptions(),
                       key: timeInput,
                       onChanged: (text) { _minutesText = text;},
                      ),
                      SizedBox(height: 4.0,),
                      RaisedButton(onPressed: (){
                          int minutes = int.parse(_minutesText);
                          Navigator.of(context).pop(Duration(minutes: minutes));
                      },
                      child: Text("OK"),),
                    ],
                  ),
               ),).then((durationPicked)=> _onDurationSelected(Colors.brown, durationPicked));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _TimerCell(
                    color: Colors.red,
                    duration: Duration(minutes: 5),
                    onTap: _onDurationSelected,
                  ),
                  _TimerCell(
                    color: Colors.green.shade700,
                    duration: Duration(minutes: 10),
                    onTap: _onDurationSelected,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _TimerCell(
                    onTap: _onDurationSelected,
                    color: Colors.lightBlue,
                    duration: Duration(minutes: 15),
                  ),
                  _TimerCell(
                    color: Colors.amber.shade600,
                    duration: Duration(minutes: 30),
                    onTap: _onDurationSelected,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerCell extends StatelessWidget {
  final Duration duration;
  final Color color;
  final _DurationSelected onTap;

  const _TimerCell({Key key, this.duration, this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => this.onTap(color, duration),
        child: Hero(
          tag: duration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TimerFace(
              color,
              duration,
            ),
          ),
        ),
      ),
    );
  }
}

typedef void _DurationSelected(Color color, Duration duration);
