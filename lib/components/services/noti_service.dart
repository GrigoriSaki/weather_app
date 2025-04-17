import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  NotificationDetails notificationDetails() {
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
        id, title, body, NotificationDetails());
  }
}
