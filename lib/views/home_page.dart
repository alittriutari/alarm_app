import 'package:alarm_test/clock_widget/clock_page.dart';
import 'package:alarm_test/common/notification_helper.dart';
import 'package:alarm_test/views/alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  //there are two main page at home page
  //Clock Page : showing usual clock
  //Alarm Page : for seting the alarm
  List listPage = [const ClockPage(), AlarmPage()];

  @override
  void initState() {
    super.initState();

    //listen if user tap the notification
    _listenNotification();
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _listenNotification() =>
      NotificationHelper().onNotification.stream.listen(_onClickNotification);

//if user tapped the notification, redirect to chat page
  void _onClickNotification(String? payload) {
    Get.to(() => ChartPage(
          payload: payload,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[900],
          onTap: _onItemTap,
          items: const [
            BottomNavigationBarItem(label: 'Clock', icon: Icon(Icons.alarm)),
            BottomNavigationBarItem(
                label: 'Alarm', icon: Icon(Icons.alarm_add_rounded))
          ]),
    );
  }
}
