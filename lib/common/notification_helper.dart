import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as timezone;

//setup notiifcation
class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  final onNotification = BehaviorSubject<String?>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSetting = AndroidInitializationSettings('app_icon');
    const iosSetting = IOSInitializationSettings(
        requestSoundPermission: false,
        requestAlertPermission: false,
        requestBadgePermission: false);
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );
  }

  Future<void> showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          bool forTomorrow = false,
          required DateTime dateTime}) async =>
      await flutterLocalNotificationsPlugin
          .zonedSchedule(
              id,
              title,
              body,
              timezone.TZDateTime.from(dateTime, timezone.local),
              await notificationDetail(dateTime),
              payload: payload,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime)
          .whenComplete(() => Fluttertoast.showToast(
                msg:
                    "Alarm has been set to ${DateFormat("dd/MM/yyyy HH:mm:ss").format(dateTime)}",
                toastLength: Toast.LENGTH_SHORT,
              ));

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    priority: Priority.high,
    importance: Importance.max,
    visibility: NotificationVisibility.public,
    enableVibration: true,
  );

  Future notificationDetail(var idDate) async {
    return NotificationDetails(
        android: _androidNotificationDetails,
        iOS: const IOSNotificationDetails());
  }

  void cancelAll() => flutterLocalNotificationsPlugin.cancelAll();
  void cancel(idDate) => flutterLocalNotificationsPlugin.cancel(idDate);
}
