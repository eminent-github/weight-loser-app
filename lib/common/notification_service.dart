// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotiPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initLocalNotification() async {
    var androidInitializationSetting =
        const AndroidInitializationSettings("@mipmap/wl_logo_white");
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSetting,
        iOS: initializationSettingsDarwin);

    await flutterLocalNotiPlugin.initialize(
      initializationSettings,
    );
    await requestIOSpermission();
    // await requestAndroidpermission();
  }

  Future<void> cancelNotificationWithId(int id) async {
    await flutterLocalNotiPlugin.cancel(id);
  }

  Future<bool> requestIOSpermission() async {
    return await flutterLocalNotiPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
        false;
  }

  Future<bool> requestAndroidpermission() async {
    return await flutterLocalNotiPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestNotificationsPermission() ??
        false;
  }

  void scheduleNotification(String title) async {
    await initLocalNotification();

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        "Alert", "Reminder Notification",
        importance: Importance.max);
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      priority: Priority.high,
      importance: Importance.max,
      ticker: "ticker",
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails();

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    print("in notification");
    await flutterLocalNotiPlugin.show(
      Random().nextInt(10000),
      "WeightLoser",
      "You haven't logged your $title for today. Would you like to do it now?",
      platformDetails,
    );
  }

  void scheduleSleepNotification(String time) async {
    await initLocalNotification();

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        "Alert", "Reminder Notification",
        importance: Importance.max);
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      priority: Priority.high,
      importance: Importance.max,
      ticker: "ticker",
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );
    print("in notification");
    await flutterLocalNotiPlugin.show(
      Random().nextInt(10000),
      "WeightLoser",
      "Your bedtime starts at $time For better sleep, play a sound of sleep",
      platformDetails,
    );
  }
}
