import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/weather_widgets/middle_widg_tile.dart';
import 'package:weather_app/data/air_quality.dart';
import 'package:weather_app/data/hourly_fore_icons.dart';
import 'package:weather_app/data/offline_data.dart';
import 'package:weather_app/provider/city_provider.dart';
import 'package:weather_app/services/api_service.dart';

// ignore: must_be_immutable
class SecondWeatherCard extends StatefulWidget {
  SecondWeatherCard({super.key});

  String? currentCity;

  @override
  State<SecondWeatherCard> createState() => _SecondWeatherCardState();
}

class _SecondWeatherCardState extends State<SecondWeatherCard> {
  String? hour;
  List<dynamic> listOfIcons = [];
  List<dynamic> listOfHours = [];
  String airQualityIndex = '';
  String pmConcentration = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAirQuality();

    final currentCity = Provider.of<CityProvider>(context).selectedCity;
    if (currentCity != widget.currentCity) {
      widget.currentCity = currentCity;
      fetchTemperature();
    }
  }

  void loadAirQuality() async {
    try {
      final pollutionData = await ApiService('0c2b6512b858613da7c1967c0e4f2e67')
          .getAirPollution(widget.currentCity ?? 'Warszawa');
      setState(() {
        airQualityIndex = pollutionData['aqi'].toString();
        pmConcentration = pollutionData['pm2_5'].toString();
      });
    } catch (e) {
      setState(() {
        airQualityIndex = '0';
        pmConcentration = '0';
      });
    }
  }

  void fetchTemperature() async {
    final apiService = ApiService('0c2b6512b858613da7c1967c0e4f2e67');

    try {
      final forecast =
          await apiService.getHourlyForecast(widget.currentCity ?? 'Warszawa');

      setState(() {
        listOfHours = forecast.map((e) => e['hour']).toList();
        listOfIcons = forecast.map((e) => e['icon']).toList();

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        final futureToday = forecast.where((e) {
          final hour = e['hour'];
          final dt = DateTime(today.year, today.month, today.day, hour);
          return dt.isAfter(now);
        }).toList();

        if (futureToday.isNotEmpty) {
          final secondForecast =
              futureToday.length >= 3 ? futureToday[2] : futureToday.last;
          hour = secondForecast['hour'].toString();
        }
      });
    } catch (e) {
      setState(() {
        hour = "99";
      });
    }
  }

  Widget build(BuildContext context) {
    RotatedBox divider = RotatedBox(
      quarterTurns: 1,
      child: Divider(
        indent: 35,
        endIndent: 35,
        thickness: 3,
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(50),
      ),
    );
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(30),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withAlpha(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Chance of rain wdget
                            MiddleWidgTile(
                              icon: listOfIcons.length > 2
                                  ? GetHourlyForecastIcon()
                                      .giveIcon(listOfIcons[2])
                                  : Icons.question_mark,
                              title: "$hour:00",
                              value: listOfIcons.length > 2
                                  ? Descriptions.getWeatherdescription(
                                      listOfIcons[2], listOfIcons[2])
                                  : "Unknown",
                            ),
                            divider,

                            //wind speed wodget
                            MiddleWidgTile(
                              icon: AirQuality()
                                  .getAirQualityIcon(airQualityIndex),
                              title: AirQuality()
                                  .getAirQualityDescription(airQualityIndex),
                              value: "Air Quality",
                            ),
                            divider,

                            //Air pressure widget
                            MiddleWidgTile(
                              icon: FontAwesomeIcons.smog,
                              title: "PM 2.5",
                              value: "$pmConcentration µg/m³",
                            ),
                          ],
                        ),
                      ),
                    )))),
      ],
    );
  }
}
