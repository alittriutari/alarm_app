import 'dart:math';

import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  final clockTextList = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  final Paint secBrush = Paint();

  final double hourTickMarkLength = 8.0;
  final double minuteTickMarkLength = 4.0;

  final double hourTickMarkWidth = 2.0;
  final double minuteTickMarkWidth = 1.0;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );
  final TextStyle secStyle =
      const TextStyle(color: Color(0xff44314A), fontSize: 16);

  @override
  void paint(Canvas canvas, Size size) {
    double tickMarkLength;
    final radius = size.width / 2;
    //declare incremental angle which is 6 degrees since need to rotate 60 times
    const angle = 2 * pi / 60;

    canvas.save();

    //draw canvas
    canvas.translate(radius, radius);

    //draw tick marks
    for (var i = 0; i < 60; i++) {
      tickMarkLength = i % 5 == 0 ? hourTickMarkLength : minuteTickMarkLength;
      secBrush.strokeWidth =
          i % 5 == 0 ? hourTickMarkWidth : minuteTickMarkWidth;
      canvas.drawLine(Offset(0.0, -radius),
          Offset(0.0, -radius + tickMarkLength), secBrush);

      //draw the text
      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0.0, -radius + 20);

        //get the text from the clockTextList
        textPainter.text =
            TextSpan(text: '${clockTextList[i ~/ 5]}', style: secStyle);

        //rotate the canvas back to 0 degrees so text is vertical
        canvas.rotate(-angle * i);
        textPainter.layout();
        textPainter.paint(canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
        canvas.restore();
      }
      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
