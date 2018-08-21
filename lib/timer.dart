import 'dart:async';

import 'package:dalton_timer/widgets/timerface.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  final Color timerColor;
  final Duration initialDuration;

  const TimerPage({Key key, this.timerColor, this.initialDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new _TimerClock(
            initialDuration: initialDuration, timerColor: timerColor),
      ),
    );
  }
}

class _TimerClock extends StatefulWidget {
  const _TimerClock({
    Key key,
    @required this.initialDuration,
    @required this.timerColor,
  }) : super(key: key);

  final Duration initialDuration;
  final Color timerColor;

  @override
  _TimerClockState createState() {
    return new _TimerClockState();
  }
}

class _TimerClockState extends State<_TimerClock>
    with SingleTickerProviderStateMixin {
  bool _running = false;
  AnimationController _timerController;
  Animation<Duration> _remainingAnimation;

  @override
  void initState() {
    super.initState();
    _running = false;
    _timerController =
        AnimationController(vsync: this, duration: widget.initialDuration);
    
    _remainingAnimation =
        Tween(begin: widget.initialDuration, end: Duration.zero)
            .animate(_timerController)..addListener((){
              setState(() {});
            });
  }

  @override
    void dispose() {
      super.dispose();
      _running = false;
      _timerController.stop();
      _timerController.dispose();
      
    }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: widget.initialDuration,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TimerFace(widget.timerColor,
                _running ? _remainingAnimation.value : widget.initialDuration, 
                initialDuration: widget.initialDuration,),
          ),
        ),
        AnimatedOpacity(
          opacity: _running ? 0.0 : 0.45,
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            child: LayoutBuilder(
                builder: (context, constraints) => Icon(
                      Icons.play_circle_outline,
                      color: Colors.black,
                      size: constraints.biggest.shortestSide,
                    )),
            onTap: () {
              _startTicking();
            },
          ),
        ),
      ],
    );
  }

  void _startTicking() {
    setState(() {
      _running = true;
      _timerController.forward();
      
    });
  }
}
