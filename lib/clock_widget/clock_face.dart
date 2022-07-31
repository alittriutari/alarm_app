import 'package:flutter/material.dart';

import 'clock_dial_painter.dart';
import 'clock_hands.dart';

//here you can define the apperarance of the clock
class ClockFace extends StatelessWidget {
  final bool isAlarm;
  const ClockFace({Key? key, this.isAlarm = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //using aspect ratio to make sure clock face width and height are the same
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Stack(
            children: [
              //define dial and numbers
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CustomPaint(
                  painter: ClockDialPainter(),
                ),
              ),
              //define clock hand (hour hand, minute hand, second hand, and center point)
              ClockHands(
                isAlarm: isAlarm,
              )
            ],
          ),
        ),
      ),
    );
  }
}
