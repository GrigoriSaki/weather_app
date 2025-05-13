import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //Inicjalizacja powiadomień
  Future<void> initNotifications() async {
    if (_isInitialized) {
      return;
    }

    //init timezone
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

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
            'weather_updates2', 'Daily Notifications2',
            channelDescription: 'Basic notifications channel',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            visibility: NotificationVisibility.public));
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
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    await notificationsPlugin.zonedSchedule(
      id, title, body, scheduledDate, notificationDetailsForAndroid(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      // repeat daily
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  //cancel notifications
  Future<void> cancelNotification() async {
    await notificationsPlugin.cancelAll();
  }
}
