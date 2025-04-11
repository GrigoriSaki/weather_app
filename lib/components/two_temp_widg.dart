import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoTempWidg extends StatelessWidget {
  const TwoTempWidg({
    super.key,
    required this.iconColor,
    required this.textColor,
    required this.lowTemp,
    required this.highTemp,
  });
  final Color iconColor;
  final Color textColor;
  final String lowTemp;
  final String highTemp;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.arrowUp, size: 15, color: iconColor),
          Text(
            highTemp + "°",
            style: GoogleFonts.lato(
                color: textColor, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(FontAwesomeIcons.arrowDown, size: 15, color: iconColor),
          Text(
            lowTemp + "°",
            style: GoogleFonts.lato(
                color: textColor, fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
