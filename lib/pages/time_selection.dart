import 'dart:async';

import 'package:dalton_timer/intl/localizations.dart';
import 'package:dalton_timer/pages/about_app.dart';
import 'package:dalton_timer/pages/settings.dart';
import 'package:dalton_timer/pages/timer.dart';
import 'package:dalton_timer/animation_state_aware_routes.dart';
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
    Future<bool> complete;

    final route = MaterialPageRouteExtended(
      builder: (BuildContext context) => TimerPage(
        timerColor: color,
        initialDuration: duration,
          animationComplete: complete
      ),
    );
    complete =  route.nextAnimationCompleted;
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<State<TextField>> timeInput = GlobalKey();
    _minutesText = null;
    var localizations = TimerAppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.pickTime),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timelapse),
            onPressed: () => _onCustomTime(context, timeInput),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _onSettings,
          ),
        ],
      ),
      body: Column(
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
    );
  }

  void _onCustomTime(
      BuildContext context, GlobalKey<State<TextField>> timeInput) {
    var localizations = TimerAppLocalizations.of(context);
    showModalBottomSheet<Duration>(
      context: context,
      builder: (BuildContext c) => Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: localizations.enterTimeInMinutesHint,
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  key: timeInput,
                  onChanged: (text) {
                    _minutesText = text;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                RaisedButton(
                  onPressed: () {
                    int minutes = int.parse(_minutesText);
                    Duration duration =
                        minutes != null ? Duration(minutes: minutes) : null;
                    Navigator.of(context).pop(duration);
                  },
                  child: Text(Localizations.of<MaterialLocalizations>(context, MaterialLocalizations).okButtonLabel),
                ),
              ],
            ),
          ),
    ).then((durationPicked) {
      if (durationPicked != null) {
        _onDurationSelected(Theme.of(context).accentColor, durationPicked);
      }
    });
  }

  void _onSettings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage(),));
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color.withOpacity(0.07),
          ),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: duration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaceWithShadow(
                    color,
                    duration,
                  ),
                ),
              ),
              Center(
                child: Transform(
                  transform: Matrix4.translationValues(0.0, Theme.of(context).textTheme.headline.fontSize*0.75, 0.0),
                  child: Hero(
                    tag: duration.inMinutes,
                    child: Text("${duration.inMinutes}", style: Theme.of(context).textTheme.headline,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

typedef void _DurationSelected(Color color, Duration duration);
