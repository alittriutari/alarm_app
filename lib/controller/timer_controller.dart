import 'dart:async';

import 'package:alarm_test/model/time.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  DateTime _dateTime = DateTime.now();
  Timer? _timer;
  final _updateDuration = const Duration(seconds: 1);

  var time = Time(second: 0, minute: 0, hour: 0, abbreviations: 'AM').obs;

  void initTimer() {
    _timer = Timer.periodic(_updateDuration, setTimer);
  }

  void disposeTimer() {
    _timer!.cancel();
  }

  void setTimer(Timer timer) {
    _dateTime = DateTime.now();
    time.update((_) {
      time.value.hour = _dateTime.hour;
      time.value.minute = _dateTime.minute;
      time.value.second = _dateTime.second;
    });
  }
}
