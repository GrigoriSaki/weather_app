import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Descriptions {
  List<String> descriptions = [
    "Sunny with clear skies.",
    "Light rain expected later.",
    "Cloudy with a breeze.",
    "Mild and partly cloudy.",
    "Short drizzle in the morning.",
    "Warm with gentle winds.",
    "Overcast but dry.",
  ];

  List<IconData> icons = [
    FontAwesomeIcons.sun,
    FontAwesomeIcons.cloudRain,
    FontAwesomeIcons.cloud,
    FontAwesomeIcons.cloudSun,
    FontAwesomeIcons.cloudShowersWater,
    FontAwesomeIcons.wind,
    FontAwesomeIcons.smog
  ];

  List<String> daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  List<String> lowTemp = [
    "10",
    "12",
    "8",
    "15",
    "9",
    "11",
    "13",
  ];

  List<String> highTemp = [
    "20",
    "22",
    "18",
    "25",
    "19",
    "21",
    "23",
  ];

  Map<String, String> todayDescription = {
    "": "Sunny with clear skies",
  };

  static String getWeatherdescription(String iconKey, String iconKey2) {
    switch (iconKey) {
      case '01d':
        switch (iconKey2) {
          case '01d':
            return "Sunny with clear skies";
          case '02d':
            return "Sunny with few clouds";
          case '03d':
            return "Sunny with scattered clouds";
          case '04d':
            return "Sunny then cloudy";
          case '09d':
          case '10d':
            return "Sun and showers";
          default:
            return "Mostly sunny";
        }

      case '02d':
        switch (iconKey2) {
          case '01d':
            return "Partly sunny";
          case '02d':
            return "Partly cloudy";
          case '03d':
            return "Clouds increasing";
          case '09d':
          case '10d':
            return "Cloudy with light rain";
          default:
            return "Partly cloudy";
        }

      case '03d':
        switch (iconKey2) {
          case '03d':
            return "Scattered clouds";
          case '04d':
            return "Mostly cloudy";
          case '09d':
          case '10d':
            return "Light rain possible";
          default:
            return "Some clouds";
        }

      case '04d':
        switch (iconKey2) {
          case '04d':
            return "Overcast skies";
          case '09d':
          case '10d':
            return "Cloudy with rain";
          default:
            return "Overcast";
        }

      case '09d':
        switch (iconKey2) {
          case '09d':
            return "Frequent showers";
          case '10d':
            return "Rainy day";
          case '11d':
            return "Rain and thunder";
          default:
            return "Passing showers";
        }

      case '10d':
        switch (iconKey2) {
          case '10d':
            return "Steady rain";
          case '11d':
            return "Rain and thunder";
          default:
            return "Light rain";
        }

      case '11d':
        switch (iconKey2) {
          case '11d':
            return "Thunderstorms";
          default:
            return "Chance of storms";
        }

      case '13d':
        switch (iconKey2) {
          case '13d':
            return "Snowfall";
          case '04d':
            return "Snow and clouds";
          default:
            return "Snowy";
        }

      case '50d':
        switch (iconKey2) {
          case '50d':
            return "Foggy conditions";
          case '04d':
            return "Fog and clouds";
          default:
            return "Low visibility";
        }

      default:
        return "Weather unknown";
    }
  }

  static IconData getWeatherIcon(String description) {
    switch (description) {
      case "Sunny with clear skies":
        return FontAwesomeIcons.sun;

      case "Mostly sunny with few clouds":
      case "Partly cloudy":
      case "Mix of sun and clouds":
      case "Cloudy with some sun":
        return FontAwesomeIcons.cloudSun;

      case "Cloudy skies":
      case "Overcast":
        return FontAwesomeIcons.cloud;

      case "Showers likely":
        return FontAwesomeIcons.cloudShowersHeavy;

      case "Rain expected":
      case "Light rain":
        return FontAwesomeIcons.cloudRain;

      case "Thunderstorms possible":
        return FontAwesomeIcons.boltLightning;

      case "Snowfall expected":
        return FontAwesomeIcons.snowflake;

      case "Some clouds":
        return FontAwesomeIcons.cloud;

      case "Mostly sunny":
        return FontAwesomeIcons.sun;

      default:
        return FontAwesomeIcons.question;
    }
  }
}
