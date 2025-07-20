import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey;

  ApiService(this.apiKey);

  Future<Map<String, double>> getCurrentTemperature(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'temp_main': data['main']['temp'].toDouble(),
        'temp_min': data['main']['temp_min'].toDouble(),
        'temp_max': data['main']['temp_max'].toDouble(),
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  //Getting City Coordinates
  Future<Map<String, double>> getCityCoordinates(String cityName) async {
    final url =
        'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      if (data.isEmpty) {
        throw Exception('City not found');
      }
      return {
        'lat': data[0]['lat'].toDouble(),
        'lon': data[0]['lon'].toDouble(),
      };
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

  //Getting hourly forecast
  Future<List<Map<String, dynamic>>> getHourlyForecast(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List hours = data['list'];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      List<Map<String, dynamic>> result = [];
      for (final hour in hours) {
        final dt =
            DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000, isUtc: true)
                .toLocal();
        final weather = hour['weather'][0];
        if (dt.year == today.year &&
            dt.month == today.month &&
            dt.day == today.day) {
          result.add({
            'hour': dt.hour,
            'temp': hour['main']['temp']?.toDouble() ?? 0.0,
            'icon': weather['icon'],
          });
        }
      }
      return result;
    } else {
      throw Exception('Failed to load hourly weather data');
    }
  }

  //Getting air pollution
  Future<Map<String, dynamic>> getAirPollution(String cityName) async {
    final coordinates = await getCityCoordinates(cityName);
    final lat = coordinates['lat'];
    final lon = coordinates['lon'];

    final url =
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final pollution = data['list'][0];

      return {
        'aqi': pollution['main']['aqi'], // 1-5
        'pm2_5': pollution['components']['pm2_5'],
      };
    } else {
      throw Exception('No AP data');
    }
  }
}
