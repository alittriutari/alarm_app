import 'package:flutter/material.dart';

import 'clock_face.dart';

class ClockBody extends StatelessWidget {
  final bool isAlarm;
  const ClockBody({Key? key, this.isAlarm = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: _buildClockCircle(),
    );
  }

  Widget _buildClockCircle() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 4.0),
              blurRadius: 8.0,
              color: Colors.grey[500]!,
            ),
          ],
        ),
        child: ClockFace(
          isAlarm: isAlarm,
        ),
      );
}
