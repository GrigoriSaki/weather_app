import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/components/middle_widg_tile.dart';

class SecondWeatherCard extends StatelessWidget {
  const SecondWeatherCard({super.key});

  @override
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
                              icon: FontAwesomeIcons.cloudRain,
                              title: "23:00",
                              value: "Slight chance of rain",
                            ),
                            divider,

                            //wind speed wodget
                            MiddleWidgTile(
                              icon: FontAwesomeIcons.wind,
                              title: "14 km/h",
                              value: "Gentle breeze now ",
                            ),
                            divider,

                            //Air pressure widget
                            MiddleWidgTile(
                              icon: FontAwesomeIcons.temperatureQuarter,
                              title: "1020 hPa",
                              value: "Stable weather",
                            ),
                          ],
                        ),
                      ),
                    )))),
      ],
    );
  }
}
