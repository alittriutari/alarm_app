import 'package:alarm_test/controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'clock_body.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  final timerController = Get.put(TimerController());

  @override
  void initState() {
    timerController.initTimer();
    super.initState();
  }

  @override
  void dispose() {
    timerController.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              //showing time from getx state management controller
              child: Obx(() => Text(
                    "${timerController.time.value.hour.toString().padLeft(2, '0')}:${timerController.time.value.minute.toString().padLeft(2, '0')}:${timerController.time.value.second.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 45),
                  )),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                //base clock widget
                child: const ClockBody(
                  //isAlarm used to differentiate clock function
                  isAlarm: false,
                ))
          ],
        ),
      ),
    );
  }
}
