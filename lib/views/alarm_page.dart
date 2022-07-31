import 'package:alarm_test/clock_widget/clock_body.dart';
import 'package:alarm_test/common/notification_helper.dart';
import 'package:alarm_test/controller/alarm_controller.dart';
import 'package:alarm_test/widgets/alarm_clock.dart';
import 'package:alarm_test/widgets/alarm_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AlarmPage extends StatelessWidget {
  AlarmPage({Key? key}) : super(key: key);

  final alarmController = Get.put(AlarmController());

  setDateTime() {
    DateTime dateTime = DateTime.now();
    return DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.hour >
                ((alarmController.alarm.value.abbreviations == "AM")
                    ? alarmController.alarm.value.hour
                    : alarmController.alarm.value.hour + 12)
            ? dateTime.day
            : dateTime.hour ==
                        ((alarmController.alarm.value.abbreviations == "AM")
                            ? alarmController.alarm.value.hour
                            : alarmController.alarm.value.hour + 12) &&
                    dateTime.minute >= alarmController.alarm.value.minute &&
                    dateTime.second > 0
                ? dateTime.day
                : dateTime.day,
        (alarmController.alarm.value.abbreviations == "AM")
            ? alarmController.alarm.value.hour
            : alarmController.alarm.value.hour + 12,
        alarmController.alarm.value.minute,
        alarmController.alarm.value.second);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Obx(
                  () =>
                      //radio button used to select which time (hour, minute, second) we want to select
                      Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlarmRadioButton(
                        groupValue: alarmController.whichAlarmSet.value,
                        radioName: 'Hour',
                        radioValue: 'hour',
                        onChanged: (value) {
                          alarmController.whichAlarmSet(value);
                        },
                      ),
                      AlarmRadioButton(
                        groupValue: alarmController.whichAlarmSet.value,
                        radioName: 'Minute',
                        radioValue: 'minute',
                        onChanged: (value) {
                          alarmController.whichAlarmSet(value);
                        },
                      ),
                      AlarmRadioButton(
                        groupValue: alarmController.whichAlarmSet.value,
                        radioName: 'Second',
                        radioValue: 'second',
                        onChanged: (value) {
                          alarmController.whichAlarmSet(value);
                        },
                      ),
                    ],
                  ),
                )),
            //showing selected alarm setting
            AlarmClock(alarmController: alarmController),
            //widget for base clock
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: const ClockBody(
                  isAlarm: true,
                )),
            const SizedBox(
              height: 20,
            ),
            //option for activated the alarm
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  //cancel alarm
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        NotificationHelper().cancelAll();
                        Fluttertoast.showToast(
                          msg: 'All alarm cancelled',
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                      child: const Text(
                        'Cancel Alarm',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                //activated the alarm
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                        onPressed: () {
                          //check if alarm setting is tommorrow or today
                          DateTime setTime = setDateTime();
                          DateTime timeNow = DateTime.now();
                          bool forTomorrow = false;
                          if (setTime.isBefore(timeNow)) {
                            setTime = setTime.add(const Duration(days: 1));
                            forTomorrow = true;
                          }
                          NotificationHelper().showScheduledNotification(
                              title: 'Alarm',
                              body: 'Alarm active',
                              forTomorrow: forTomorrow,
                              payload: setTime.toString(),
                              dateTime: setTime);
                        },
                        child: const Text('Set Alarm'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
