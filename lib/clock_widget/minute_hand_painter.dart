import 'dart:math';

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter {
  var minuteBrush = Paint();
  final int minutes;
  final int seconds;
  final Color color;

  MinuteHandPainter(
      {required this.minutes, required this.seconds, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    minuteBrush = Paint()..color = color;
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((minutes + (seconds / 60)) / 60));

    Path minuteHand = Path();
    minuteHand.moveTo(-1.0, -radius + radius / 10);
    minuteHand.lineTo(-4.0, -radius + radius / 4);
    minuteHand.lineTo(-2.0, 0.0);
    minuteHand.lineTo(2.0, 0.0);
    minuteHand.lineTo(4.0, -radius + radius / 4);
    minuteHand.lineTo(1.0, -radius + radius / 10);
    minuteHand.close();

    canvas.drawPath(minuteHand, minuteBrush);
    canvas.drawShadow(minuteHand, color, 4.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
