import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/two_temp_widg.dart';

class AnimatedTempWidget extends StatefulWidget {
  final bool isExpanded;
  const AnimatedTempWidget({super.key, required this.isExpanded});

  @override
  State<AnimatedTempWidget> createState() => _AnimatedTempWidgetState();
}

class _AnimatedTempWidgetState extends State<AnimatedTempWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Today",
              style: GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                TwoTempWidg(
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  lowTemp: "18",
                  highTemp: "25",
                  iconColor:
                      Theme.of(context).colorScheme.onPrimary.withAlpha(200),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
        widget.isExpanded
            ? RotatedBox(
                quarterTurns: 3,
                child: Divider(
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(50),
                  thickness: 3,
                  endIndent: 5,
                  indent: 5,
                ),
              )
            : SizedBox(),
        widget.isExpanded
            ? Column(
                children: [
                  Text(
                    "Tomorrow",
                    style: GoogleFonts.lato(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      TwoTempWidg(
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        lowTemp: "18",
                        highTemp: "25",
                        iconColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(200),
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }
}
