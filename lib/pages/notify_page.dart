import 'package:flutter/material.dart';
import 'package:weather_app/components/services/noti_service.dart';

class NotifyPage extends StatelessWidget {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Center(
            child: TextButton(
                onPressed: () {
                  NotiService().showNotification(
                      title: "Test notification",
                      body: "This is a test notification");
                },
                child: Text("Send notification"))),
      ),
    );
  }
}
