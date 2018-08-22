

import 'package:dalton_timer/pages/timer.dart';
import 'package:dalton_timer/widgets/faces.dart';
import 'package:flutter/material.dart';

class TimeSelectionPage extends StatefulWidget {
  const TimeSelectionPage({
    Key key,
  }) : super(key: key);

  @override
  _TimeSelectionPageState createState() {
    return new _TimeSelectionPageState();
  }
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
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
            child: FaceWithShadow(
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
