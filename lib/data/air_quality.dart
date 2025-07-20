import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AirQuality {
  String getAirQualityDescription(String airQuality) {
    switch (airQuality) {
      case '1':
        return 'GOOD';
      case '2':
        return 'FAIR';
      case '3':
        return 'MODERATE';
      case '4':
        return 'POOR';
      case '5':
        return 'VERY POOR';
      default:
        return 'Unknown';
    }
  }

  IconData getAirQualityIcon(String airQuality) {
    switch (airQuality) {
      case '1':
        return FontAwesomeIcons.faceSmile;
      case '2':
        return FontAwesomeIcons.faceLaughBeam;
      case '3':
        return FontAwesomeIcons.faceMeh;
      case '4':
        return FontAwesomeIcons.faceFrown;
      case '5':
        return FontAwesomeIcons.skullCrossbones;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }
}
