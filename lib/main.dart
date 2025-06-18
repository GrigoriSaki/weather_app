import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/city_provider.dart';
import 'package:weather_app/services/firestore.dart';
import 'package:weather_app/services/noti_service.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/pages/home_with_panel.dart';
import 'package:weather_app/theme/dark_mode.dart';
import 'package:weather_app/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreService = FirestoreService();
  await firestoreService.seedCities();

  final notiService = NotiService();
  await notiService.initNotifications();

  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CityProvider())],
      child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: HomeWithPanel()),
    );
  }
}
