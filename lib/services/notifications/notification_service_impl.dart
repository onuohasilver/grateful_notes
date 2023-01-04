import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grateful_notes/services/notifications/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tzz;

class NotificationServiceImpl extends NotificationService {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  const NotificationServiceImpl();

  @override
  Future<bool> requestPermission() async {
    bool value = false;
    _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission()
        .then((_) => value = _!);
    return value;
  }

  @override
  Future<void> initialize(onDidReceiveNotificationResponse) async {
    tz.initializeTimeZones();

    // tzz.setLocalLocation(tzz.getLocation("Lagosx"));
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  @override
  Future<void> sendNotification(
      {required String title,
      required String body,
      required String payload}) async {
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('HappyNotes01', 'HappyNotes',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'Resela');
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await _notification.show(0, title, body, notificationDetails,
        payload: payload);
  }

  scheduleNotification(
      {required String title,
      required String body,
      required String payload,
      TimeOfDay? timeOfDay,
      DateTimeComponents? dateTimeComponents = DateTimeComponents.time}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'HappyNotes01',
      'HappyNotes',
      channelDescription: 'Notifications from happy notes',
      importance: Importance.max,
      ticker: "HappyNotes1",
      priority: Priority.high,
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    DateTime dt = DateTime.now();

    await _notification.zonedSchedule(
        0,
        title,
        body,
        tzz.TZDateTime.from(
            DateTime(
                dt.year, dt.month, dt.day, timeOfDay!.hour, timeOfDay.minute),
            tzz.local),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: payload,
        matchDateTimeComponents: dateTimeComponents,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
