import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetHourlyForecastIcon {
  giveIcon(String code) {
    switch (code) {
      case '01d':
        return FontAwesomeIcons.sun;
      case '01n':
        return FontAwesomeIcons.moon;
      case '02d':
        return FontAwesomeIcons.cloudSun;
      case '02n':
        return FontAwesomeIcons.cloudMoon;
      case '03d':
        return FontAwesomeIcons.cloudSun;
      case '03n':
        return FontAwesomeIcons.cloudMoon;
      case '04d':
      case '04n':
        return FontAwesomeIcons.cloud;
      case '09d':
      case '09n':
        return FontAwesomeIcons.cloudShowersWater;
      case '10d':
      case '10n':
        return FontAwesomeIcons.cloudRain;
      case '11d':
      case '11n':
        return FontAwesomeIcons.boltLightning;
      case '13d':
      case '13n':
        return FontAwesomeIcons.snowflake;
      case '50d':
      case '50n':
        return FontAwesomeIcons.smog;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
