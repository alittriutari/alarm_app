import 'package:alarm_test/model/time.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController {
  var alarm = Time(hour: 0, minute: 0, second: 0, abbreviations: 'AM').obs;
  var whichAlarmSet = "hour".obs;
  void setAlarm(key, value) {
    alarm.update((_) {
      if (value == 60) value = 0;
      if (alarm.value.abbreviations == "AM") {
        if (value == 12 && key != "minute" && key != "second") value = 0;
      }
      if (key == "hour") alarm.value.hour = value;
      if (key == "minute") alarm.value.minute = value;
      if (key == "second") alarm.value.second = value;
      if (key == "abbreviations") alarm.value.abbreviations = value;
    });
  }

  void setWhichAlarm(type) {
    whichAlarmSet = type;
  }
}
