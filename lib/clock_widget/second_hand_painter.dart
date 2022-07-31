import 'dart:math';

import 'package:flutter/material.dart';

class SecondHandPainter extends CustomPainter {
  var secondBrush = Paint();
  var centerDotBrush = Paint();

  final int seconds;
  final Color color;
  SecondHandPainter({required this.seconds, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    secondBrush = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    centerDotBrush = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final double radius = size.width / 2;

    canvas.save();
    canvas.translate(radius, radius);
    canvas.rotate(2 * pi * (seconds / 60));

    Path secondHand = Path();
    Path centerDot = Path();

    secondHand.moveTo(0.0, -radius);
    secondHand.lineTo(0.0, radius / 4);

    centerDot
        .addOval(Rect.fromCircle(center: const Offset(0.0, 0.0), radius: 5.0));

    canvas.drawPath(secondHand, secondBrush);
    canvas.drawPath(centerDot, centerDotBrush);

    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) {
    return seconds != oldDelegate.seconds;
  }
}
