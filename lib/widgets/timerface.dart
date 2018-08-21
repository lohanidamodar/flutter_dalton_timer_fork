
import 'dart:math';

import 'package:flutter/material.dart';

class TimerFace extends StatelessWidget {
  final Color color;
  final Duration duration;
  final Duration initialDuration;

  const TimerFace(this.color, this.duration, {Key key, this.initialDuration}) :
   super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TimerFacePainter(color, duration, initialDuration: this.initialDuration),
    );
  }
}

class _TimerFacePainter extends CustomPainter {
  final Color color;
  final Duration duration;
  final Paint _faceBorderPaint;
  final Paint _remainingPaint;
  final Color _lightTextColor;
  final Color _darkTextColor;
  final Duration _initial;
  final Paint _shadowPaint;
  _TimerFacePainter(this.color, this.duration, {Duration initialDuration})
      : _faceBorderPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
        _remainingPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        _lightTextColor = Colors.white70,
        _darkTextColor = Colors.black,
        _initial = initialDuration ?? duration,
        _shadowPaint = Paint()
          ..color = color.withOpacity(0.34)
          ..style = PaintingStyle.fill;

  static const Duration _HOUR = Duration(hours: 1);
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);
    // draw face border
    canvas.drawCircle(center, radius, _faceBorderPaint);

    final startAngle = -pi / 2;
    // draw shadow
    final initialSweepAngle = (_initial.inMilliseconds / _HOUR.inMilliseconds) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, initialSweepAngle, true, _shadowPaint);

    // draw duration
    final sweepAngle =
        (duration.inMilliseconds / _HOUR.inMilliseconds) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, sweepAngle, true, _remainingPaint);

    // presenting text
    final aboveHalfAnHour = sweepAngle > pi;
    Color textColor;
    String text = "${duration.inMinutes}";
    double textX;

    if (aboveHalfAnHour) {
      textColor = _lightTextColor;
      textX = centerX + radius / 2;
    } else {
      textColor = _darkTextColor;
      textX = centerX - radius / 2;
    }
    final timePainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: textColor, fontSize: radius / 3.0),
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    timePainter.layout(maxWidth: radius / 2);
    timePainter.paint(
        canvas,
        Offset(
            textX - timePainter.width / 2, centerY - timePainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _oldPainter = (oldDelegate as _TimerFacePainter);
    return !(_oldPainter.color == this.color &&
        _oldPainter.duration == this.duration);
  }
}
