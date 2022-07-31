import 'dart:math';

import 'package:flutter/cupertino.dart';

class HourHandPainter extends CustomPainter {
  var hourBrush = Paint();
  final int hours;
  final int minutes;
  final Color color;

  HourHandPainter(
      {required this.hours, required this.minutes, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    hourBrush = Paint()..color = color;
    final radius = size.width / 2;

    //start draw hand
    canvas.save();

    //move canvas from top left position to center of clock face
    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    canvas.rotate(hours >= 12
        ? 2 * pi * ((hours - 12) / 12 + (minutes / 720))
        : 2 * pi * ((hours / 12) + (minutes / 720)));

    Path hourHand = Path();

    //draw hour hand
    hourHand.moveTo(-1.0, -radius + radius / 4);
    hourHand.lineTo(-5.0, -radius + radius / 2);
    hourHand.lineTo(-2.0, 0.0);
    hourHand.lineTo(2.0, 0.0);
    hourHand.lineTo(5.0, -radius + radius / 2);
    hourHand.lineTo(1.0, -radius + radius / 4);
    hourHand.close();

    canvas.drawPath(hourHand, hourBrush);
    canvas.drawShadow(hourHand, color, 7.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
