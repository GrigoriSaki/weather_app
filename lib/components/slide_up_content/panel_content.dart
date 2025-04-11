import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/my_clippers.dart';
import 'package:weather_app/components/slide_up_content/hourly_forecast.dart';
import 'package:weather_app/components/slide_up_content/tommorow_forecast.dart';

class PanelContent extends StatelessWidget {
  const PanelContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopEdgeCurved(),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Padding(
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
              Text("Tommorow",
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface)),
              SizedBox(
                height: 10,
              ),
              TommorowForecast()
            ],
          ),
        ),
      ),
    );
  }
}
