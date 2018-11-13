import 'dart:async';
import 'dart:math';

import 'package:dalton_timer/screenwakelock.dart';
import 'package:dalton_timer/sound_manager.dart';
import 'package:dalton_timer/widgets/faces.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  final Color timerColor;
  final Duration initialDuration;
  final Future<bool> animationComplete;

  const TimerPage(
      {Key key, this.timerColor, this.initialDuration, this.animationComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new _TimerClock(
            initialDuration: initialDuration,
            timerColor: timerColor,
            pageReady: animationComplete),
      ),
    );
  }
}

class _TimerClock extends StatefulWidget {
  const _TimerClock({
    Key key,
    @required this.initialDuration,
    @required this.timerColor,
    @required this.pageReady,
  }) : super(key: key);

  final Duration initialDuration;
  final Color timerColor;
  final Future<bool> pageReady;

  @override
  _TimerClockState createState() {
    return new _TimerClockState();
  }
}

class _TimerClockState extends State<_TimerClock>
    with SingleTickerProviderStateMixin {
  bool _running = false;
  AnimationController _timerController;
  // ignore: unused_field
  Animation<Duration> _remainingAnimation;

  int _minutesLeft;

  bool _pageReadyFlag;

  DateTime _initialTime;

  DateTime _finishTime;

  @override
  void initState() {
    super.initState();
    _running = false;
    _pageReadyFlag = false;
    _minutesLeft = widget.initialDuration.inMinutes;
    _timerController =
        AnimationController(vsync: this, duration: widget.initialDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed ||
                status == AnimationStatus.completed) {
              _clearScreenAwakeLock();
            }
          });

    _remainingAnimation = Tween(
            begin: widget.initialDuration, end: Duration.zero)
        .animate(_timerController)
          ..addListener(() {
            final millisecondsLeft =
                _finishTime.difference(DateTime.now()).inMilliseconds;
            final newMinutesLeft = max((millisecondsLeft / 60000).ceil(), 0);

            if (millisecondsLeft <= 0) {
              _playAlarmSound(context);
              _timerController.stop();
            }
            setState(() {
              _minutesLeft = newMinutesLeft;
            });
          });
    widget.pageReady.then((value) {
      setState(() {
        _pageReadyFlag = true;
      });
    });
  }

  @override
  void dispose() {
    _running = false;
    _timerController.dispose();
    _clearScreenAwakeLock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    var currentDuration = _running
        ? _finishTime.difference(DateTime.now())
        : widget.initialDuration;
    if (currentDuration.isNegative){
      currentDuration = Duration();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Hero(
                tag: widget.initialDuration.inMinutes,
                child: Text(
                  "$_minutesLeft",
                  style: appTheme.textTheme.display3
                      .copyWith(fontWeight: FontWeight.bold),
                )),
          ),
        ),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: widget.initialDuration,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: FaceFromSettings(
                    color: widget.timerColor,
                    duration: currentDuration,
                    initialDuration: widget.initialDuration,
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _running || (!_pageReadyFlag) ? 0.0 : 0.36,
                child: GestureDetector(
                  child: LayoutBuilder(
                      builder: (context, constraints) => Icon(
                            Icons.play_circle_outline,
                            color: appTheme.textTheme.display3.color,
                            size: constraints.biggest.shortestSide,
                          )),
                  onTap: () {
                    _startTicking();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _startTicking() {
    _setScreenAwakeLock();
    setState(() {
      _initialTime = DateTime.now();
      _finishTime = _initialTime.add(widget.initialDuration);
      _running = true;
      _timerController.forward();
    });
  }

  void _setScreenAwakeLock() {
    setAwake();
  }

  void _clearScreenAwakeLock() {
    clearAwake();
  }

  void _playAlarmSound(BuildContext context) {
    SoundsProvider.of(context).playAlarm();
  }
}
