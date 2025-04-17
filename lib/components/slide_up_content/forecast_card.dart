import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/two_temp_widg.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.comment,
    required this.day_of_week,
    required this.low_temp,
    required this.high_temp,
    required this.weather_icon,
  });

  final String comment;
  final String day_of_week;
  final String low_temp;
  final String high_temp;
  final IconData weather_icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withAlpha(50),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 4,
          )
        ],
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                weather_icon,
                size: 42,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day_of_week,
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface)),
                  Text(comment,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(100)))
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TwoTempWidg(
                        textColor: Theme.of(context).colorScheme.onSurface,
                        iconColor: Colors.black,
                        lowTemp: low_temp,
                        highTemp: high_temp,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
