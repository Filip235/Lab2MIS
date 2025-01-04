import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


void initializeTimeZones() {
  tz.initializeTimeZones();
}


class FirebaseMessagingService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void setupFirebaseMessaging() async {

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Побарајте дозвола за push нотификации
    await FirebaseMessaging.instance.requestPermission();

    // Генерирајте токен (корисно за тестирање)
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    // Слушајте за foreground нотификации
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(
          message.notification!.title,
          message.notification!.body,
        );
      }
    });
  }

  static void showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'jokes_channel', // Идентификатор за каналот
      'Jokes Notifications', // Име на каналот
      channelDescription: 'Notifications about jokes',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );

  }

  static void scheduleDailyNotification() async {
    final now = DateTime.now();
    final scheduledTime = tz.TZDateTime.from(
      DateTime(now.year, now.month, now.day, 12, 0), // 12:00 PM
      tz.local,
    );

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails('daily_channel', 'Daily Joke',
        channelDescription: 'Reminder to check the joke of the day',
        importance: Importance.max,
        priority: Priority.high);

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Joke Reminder',
      'Check out the joke of the day!',
      scheduledTime,
      notificationDetails,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

}

