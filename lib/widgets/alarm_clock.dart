import 'package:alarm_test/controller/alarm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmClock extends StatelessWidget {
  final AlarmController alarmController;
  const AlarmClock({Key? key, required this.alarmController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: Text(
                  "${alarmController.alarm.value.hour.toString().padLeft(2, '0')}:${alarmController.alarm.value.minute.toString().padLeft(2, '0')}:${alarmController.alarm.value.second.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  focusColor: Colors.red,
                  isDense: true,
                  style: const TextStyle(fontSize: 30, color: Colors.black),
                  value: alarmController.alarm.value.abbreviations,
                  items: [
                    "AM",
                    "PM",
                  ].map((value) {
                    return DropdownMenuItem(
                      child: Text(
                        value,
                      ),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    alarmController.setAlarm("abbreviations", value);
                  },
                ),
              )
            ],
          )),
    );
  }
}
