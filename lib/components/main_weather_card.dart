import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/theme/gradient_text.dart';

class MainWeatherCard extends StatelessWidget {
  const MainWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Today, 22 Oct, 14:07",
                style: GoogleFonts.lato(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),

            //Main Temperature
            Positioned(
                top: 5,
                left: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      text: "17",
                      fontSize: 130,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      applyHeightBehaviors: false,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GradientText(
                          text: "°" + "C",
                          fontSize: 50,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          applyHeightBehaviors: true,
                        )),
                  ],
                )),
            Positioned(
                right: 2,
                top: 30,
                child: RotatedBox(
                    quarterTurns: 3,
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
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ))),

            //Predicted Temperature for today
            Positioned(
                bottom: 15,
                left: 2,
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
