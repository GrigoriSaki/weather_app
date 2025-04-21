import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //Inicjalizacja powiadomień
  Future<void> initNotifications() async {
    if (_isInitialized) {
      return;
    }

    //inicjalizacja dla Androida
    const initiSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    //inicjalizacja
    const initSettings = InitializationSettings(
      android: initiSettingsAndroid,
    );

    await notificationsPlugin.initialize(initSettings);
  }

  //Notification details

  NotificationDetails notificationDetailsForAndroid() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'basic_channel', 'Daily Notifications',
            channelDescription: 'Basic notifications channel',
            importance: Importance.max,
            priority: Priority.high));
  }

  //show notification
  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    return await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetailsForAndroid(),
    );
  }

//schedule notification
  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    //get the current time in device's local timezone

    final now = tz.TZDateTime.now(tz.local);

    //create the date and time for today at specified hour and minute
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    //scheduled the notification
    await notificationsPlugin.zonedSchedule(
        id, title, body, scheduledDate, NotificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle);
  }
}
