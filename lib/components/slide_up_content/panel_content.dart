import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/my_clippers.dart';
import 'package:weather_app/components/slide_up_content/hourly_forecast.dart';
import 'package:weather_app/components/slide_up_content/forecast_card.dart';
import 'package:weather_app/data/offline_data.dart';

// ignore: must_be_immutable
class PanelContent extends StatefulWidget {
  double panelPosition;
  final String dsiplayedText;
  ScrollController scrollController;

  PanelContent({
    super.key,
    required this.panelPosition,
    required this.dsiplayedText,
    required this.scrollController,
  });

  @override
  State<PanelContent> createState() => _PanelContentState();
}

class _PanelContentState extends State<PanelContent> {
  Descriptions descriptions = Descriptions();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopEdgeCurved(),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 3,
                    endIndent: 150,
                    indent: 150,
                  ),
                  Text("Hourly Forecast",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 110,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return HourlyForecast(
                              icon: FontAwesomeIcons.cloudBolt,
                              hour: "09:00 AM",
                              temperature: "20",
                            );
                          })),
                  Text(widget.dsiplayedText,
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface)),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                controller: widget.scrollController,
                physics: widget.panelPosition == 0
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 25, right: 25, top: 0),
                    child: ForecastCard(
                      weather_icon: FontAwesomeIcons.cloudSun,
                      day_of_week: descriptions.daysOfWeek[index],
                      comment: descriptions.descriptions[index],
                      low_temp: descriptions.lowTemp[index],
                      high_temp: descriptions.highTemp[index],
                    ),
                  );
                },
                itemCount: 7,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
