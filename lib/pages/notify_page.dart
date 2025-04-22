import 'package:flutter/material.dart';
import 'package:weather_app/components/services/noti_service.dart';

class NotifyPage extends StatelessWidget {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  NotiService().showNotification(
                      title: "Test notification",
                      body: "This is a test notification");
                },
                child: Text("Send notification")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  NotiService().scheduleNotification(
                    title: "Test schedule noti",
                    body: "This is a test schedule notification",
                    hour: 17,
                    minute: 53,
                  );
                },
                child: Text("Schedule notification")),
          ],
        )),
      ),
    );
  }
}
