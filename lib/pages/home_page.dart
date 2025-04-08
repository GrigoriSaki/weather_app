import 'package:flutter/material.dart';
import 'package:weather_app/components/weather_widgets/main_weather_card.dart';
import 'package:weather_app/components/my_app_bar.dart';
import 'package:weather_app/components/drawer/my_drawer.dart';
import 'package:weather_app/components/weather_widgets/second_weather_card.dart';

class HomePage extends StatefulWidget {
  final double panelPosition;
  const HomePage({
    super.key,
    required this.panelPosition,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/images/weather_back.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              MyAppBar(),
              MainWeatherCard(
                panelPosition: widget.panelPosition,
              ),
              SecondWeatherCard(),
            ],
          ),
        ),
      ),
    );
  }
}
