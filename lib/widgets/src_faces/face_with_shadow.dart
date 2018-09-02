
import 'dart:math';

import 'package:flutter/material.dart';

class FaceWithShadow extends StatelessWidget {
  final Color color;
  final Duration duration;
  final Duration initialDuration;

  const FaceWithShadow(this.color, this.duration, {Key key, this.initialDuration}) :
   super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _FaceWithShadowRemaining(color, duration),
      painter: _FaceWithShadowBackground(color, initialDuration ?? duration),
    );
  }
}

const Duration _HOUR = Duration(hours: 1);
const double _2_PI = 2* pi;
  
class _FaceWithShadowRemaining extends CustomPainter {

  final Color color;
  final Duration duration;
  final double _angle;
  final Paint _remainingPaint;
  final Color _lightTextColor;
  final Color _darkTextColor;

  _FaceWithShadowRemaining(this.color, this.duration):
  this._angle = _2_PI * (duration.inMilliseconds / _HOUR.inMilliseconds),
        _remainingPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        _lightTextColor = Colors.white70,
        _darkTextColor = Colors.black;

  @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      if (oldDelegate is _FaceWithShadowRemaining){
        return !(oldDelegate.duration == duration && oldDelegate.color == color);
      } else {
        return true;
      }
    }
    @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);
    final startAngle = - pi / 2;    
    // draw duration
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, _angle, true, _remainingPaint);

    // presenting text
    /*final aboveHalfAnHour = _angle > pi;
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
  */
    }
}

class _FaceWithShadowBackground extends CustomPainter {
  final Color color;
  final Paint _faceBorderPaint;
  final Duration initialDuration;
  final Paint _shadowPaint;
  _FaceWithShadowBackground(this.color, this.initialDuration)
      :
   _faceBorderPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
          _shadowPaint = Paint()
          ..color = color.withOpacity(0.4)
          ..style = PaintingStyle.fill;

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
    final initialSweepAngle = (initialDuration.inMilliseconds / _HOUR.inMilliseconds) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, initialSweepAngle, true, _shadowPaint);
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _oldPainter = (oldDelegate as _FaceWithShadowBackground);
    return !(_oldPainter.color == this.color &&
        _oldPainter.initialDuration == this.initialDuration);
  }
}
