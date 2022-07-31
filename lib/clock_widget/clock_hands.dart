import 'dart:math';

import 'package:alarm_test/controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/alarm_controller.dart';
import 'hour_hand_painter.dart';
import 'minute_hand_painter.dart';
import 'second_hand_painter.dart';

class ClockHands extends StatelessWidget {
  final bool isAlarm;
  ClockHands({Key? key, this.isAlarm = false}) : super(key: key);

  final timerController = Get.find<TimerController>();
  final alarmController = Get.put(AlarmController());

  _panUpdateHandler(DragUpdateDetails details) {
    if (isAlarm) {
      int x = (details.localPosition.dx - 90).ceil();
      int y = (90 - details.localPosition.dy).ceil();
      double tanValue = y / x;
      double radian = atan(tanValue);
      double degress = ((360 - ((radian * 57.2958) + 90)) - 180);
      int value = 0;
      if (alarmController.whichAlarmSet.value == "hour") {
        value = (degress / 30).ceil();
        if (x < 0) value = value + 6;
      } else {
        value = (degress / 6).ceil();
        if (x < 0) value = value + 30;
      }
      alarmController.setAlarm(alarmController.whichAlarmSet.value, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AspectRatio(
        aspectRatio: 1.0,
        child: SizedBox(
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                //using painter to draw the shape of the clock hand
                CustomPaint(
                  painter: HourHandPainter(
                    color: const Color(0xff44314A),
                    hours: isAlarm
                        ? alarmController.alarm.value.hour
                        : timerController.time.value.hour,
                    minutes: isAlarm
                        ? alarmController.alarm.value.minute
                        : timerController.time.value.minute,
                  ),
                ),
                CustomPaint(
                  painter: MinuteHandPainter(
                      color: const Color(0xffe7bd62),
                      minutes: isAlarm
                          ? alarmController.alarm.value.minute
                          : timerController.time.value.minute,
                      seconds: isAlarm
                          ? alarmController.alarm.value.second
                          : timerController.time.value.second),
                ),
                //gesture detector used for detect user gesture when drag the clock hand
                GestureDetector(
                  onPanUpdate: _panUpdateHandler,
                  child: CustomPaint(
                    painter: SecondHandPainter(
                        seconds: isAlarm
                            ? alarmController.alarm.value.second
                            : timerController.time.value.second,
                        color: const Color(0xffd15c5f)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
