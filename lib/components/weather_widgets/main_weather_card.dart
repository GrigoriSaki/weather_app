import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/theme/gradient_text.dart';

class MainWeatherCard extends StatelessWidget {
  final double panelPosition;
  MainWeatherCard({super.key, required this.panelPosition});

  final String formattedDate =
      DateFormat('E, MMM d HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    double scale = 1.0 - (panelPosition * 0.1);
    double offset = -(panelPosition * 10);
    double offsetTopC = -(panelPosition * 5);
    double offsetRightC = -(panelPosition * 10);
    double widgetHeight = MediaQuery.of(context).size.height * 0.25;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: widgetHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            //Date Time
            Positioned(
              top: 2,
              left: 2,
              child: Text(
                formattedDate,
                style: GoogleFonts.lato(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),

            //Main Temperature
            Positioned(
              top: 5 + offset,
              left: 2,
              child: Transform.scale(
                scale: scale,
                child: GradientText(
                  text: "17",
                  fontSize: 130,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  applyHeightBehaviors: false,
                ),
              ),
            ),
            Positioned(
              top: 10 + offsetTopC,
              left: 140 + offsetRightC,
              child: Transform.scale(
                scale: scale,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GradientText(
                      text: "°" + "C",
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      applyHeightBehaviors: true,
                    )),
              ),
            ),
            Positioned(
                right: 2 + panelPosition * 130,
                top: 30,
                child: RotatedBox(
                    quarterTurns: 3,
                    child: Transform.rotate(
                      angle: 0 + (panelPosition * 1.57),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.cloudSun,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Mostly Cloudy",
                              style: GoogleFonts.lato(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ))),

            //Predicted Temperature for today
            Positioned(
                bottom: 15 + (panelPosition * 110),
                left: 2 + (panelPosition * 190),
                child: Container(
                  height: 40,
                  width: 135,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withAlpha(40),
                          width: 2),
                      color:
                          Theme.of(context).colorScheme.onPrimary.withAlpha(30),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(FontAwesomeIcons.arrowUp,
                            size: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withAlpha(200)),
                        Text(
                          "24" + "°",
                          style: GoogleFonts.lato(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          FontAwesomeIcons.arrowDown,
                          size: 15,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withAlpha(200),
                        ),
                        Text(
                          "18" + "°",
                          style: GoogleFonts.lato(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
