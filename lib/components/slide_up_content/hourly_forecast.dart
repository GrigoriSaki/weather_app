import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HourlyForecast extends StatelessWidget {
  final IconData icon;
  final String hour;
  final String temperature;
  const HourlyForecast(
      {super.key,
      required this.icon,
      required this.hour,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //icon
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                icon,
                size: 30,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),

            //hour
            Text(hour,
                style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(150))),

            //temperature
            Text("$temperature°",
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
