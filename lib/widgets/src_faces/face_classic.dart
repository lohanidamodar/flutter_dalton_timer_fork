import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FaceClassic extends StatelessWidget {
  final Duration duration;
  final Duration initialDuration;

  const FaceClassic(this.duration, {Key key, this.initialDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomPaint(
      painter: _FaceClassicBackgroundPainter(theme.textTheme.body1.color),
      foregroundPainter: _PointerPainter(duration, initialDuration ?? duration,
          theme.primaryColorDark, theme.primaryTextTheme.body1.color),
    );
  }
}

class _FaceClassicBackgroundPainter extends CustomPainter {
  _FaceClassicBackgroundPainter([Color borderColor = Colors.black])
      : _borderPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = borderColor
          ..strokeWidth = 2.0;
  final Paint _borderPaint;
  final _5minutesPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;
  final _10minutesPaint = Paint()
    ..color = Colors.green.shade700
    ..style = PaintingStyle.fill;
  final _15minutesPaint = Paint()
    ..color = Colors.lightBlue
    ..style = PaintingStyle.fill;
  final _30minutesPaint = Paint()
    ..color = Colors.amber.shade600
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    var startAngle = -pi / 2;
    // 5 minutes
    var angle = pi * 1 / 6;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, angle, true, _5minutesPaint);
    startAngle += angle;
    // 10 minutes
    angle = pi * 1 / 3;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, angle, true, _10minutesPaint);
    startAngle += angle;
    // 15 minutes
    angle = pi * 0.5;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, angle, true, _15minutesPaint);
    startAngle += angle;
    // 30 minutes
    angle = pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 1.0),
        startAngle, angle, true, _30minutesPaint);

    //draw border
    canvas.drawCircle(center, radius, _borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

const _HOUR = Duration(hours: 1);

class _PointerPainter extends CustomPainter {
  final Duration remaining;
  final Duration initial;
  final Paint _pointerPaint;
  final Paint _centerDotPaint;
  final Paint _customPaint;

  static final Map<Duration, double> initialAngles = {
    Duration(minutes: 5): 0.0,
    Duration(minutes: 10): pi * 1 / 6,
    Duration(minutes: 15): pi * 1 / 2,
    Duration(minutes: 30): pi,
  };

  _PointerPainter(
      this.remaining, this.initial, Color pointerColor, Color pinColor)
      : _pointerPaint = Paint()
          ..color = pointerColor
          ..style = PaintingStyle.fill,
        _centerDotPaint = Paint()
          ..color = pinColor
          ..style = PaintingStyle.fill,
        _customPaint = initialAngles.containsKey(initial)
            ? null
            : (Paint()
              ..color = pointerColor.withOpacity(0.3)
              ..style = PaintingStyle.fill);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    final initialRotation = initialAngles[initial] ?? 0.0;

    final rotation = initialRotation +
        2 * pi * ((initial - remaining).inMilliseconds / _HOUR.inMilliseconds);
    final foundation = radius * 0.03;

    if (_customPaint != null) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius - 1.0),
          -pi / 2,
          2 * pi * (initial.inMilliseconds / _HOUR.inMilliseconds),
          true,
          _customPaint);
    }

    canvas.save();

    canvas.translate(centerX, centerY);
    canvas.rotate(rotation);
    canvas.translate(0.0, radius * 0.1);

    final Path pointerPath = Path()
      ..moveTo(-foundation, 0.0)
      ..relativeLineTo(foundation * 0.4, -radius * .9)
      ..relativeArcToPoint(
        Offset(foundation * 1.2, 0.0),
        radius: Radius.elliptical(foundation * 0.6, foundation * 3),
      )
      ..relativeLineTo(foundation * 0.4, radius * .9)
      ..close();

    canvas.drawPath(pointerPath, _pointerPaint);
    canvas.restore();

    canvas.drawCircle(center, foundation * 0.35, _centerDotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPointerPainter = oldDelegate as _PointerPainter;
    return oldPointerPainter.remaining != this.remaining ||
        oldPointerPainter.initial != this.initial;
  }
}
