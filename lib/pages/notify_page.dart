import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/components/services/noti_service.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  bool isSwitched = false;
  bool isLoading = true;
  void _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switchState', value);
  }

  void _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('switchState') ?? false;
      isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    _loadSwitchState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                )),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Turn on notifications",
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const Spacer(),
                  Switch(
                      value: isSwitched,
                      onChanged: (bool newValue) {
                        setState(() {
                          isSwitched = newValue;
                          _saveSwitchState(newValue);
                          if (isSwitched) {
                            NotiService().initNotifications();
                            NotiService().showNotification(
                                title: "Test notification",
                                body: "This is a test notification");
                            NotiService().scheduleNotification(
                              title: "Test schedule noti",
                              body: "This is a  schedule notification",
                              hour: 20,
                              minute: 23,
                            );
                          } else {
                            NotiService().notificationsPlugin.cancelAll();
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
