import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/weather_widgets/main_weather_card.dart';
import 'package:weather_app/components/my_app_bar.dart';
import 'package:weather_app/components/weather_widgets/second_weather_card.dart';
import 'package:weather_app/provider/city_provider.dart';

class HomePage extends StatefulWidget {
  final double panelPosition;
  final double blurValue;

  const HomePage({
    super.key,
    required this.panelPosition,
    required this.blurValue,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CityProvider>(context, listen: false).loadFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              blurValue: widget.blurValue,
            ),
            SecondWeatherCard(),
          ],
        ),
      ),
    );
  }
}
