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
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coord = data['coord'];
      return {
        'lat': coord['lat'].toDouble(),
        'lon': coord['lon'].toDouble(),
      };
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

  //Getting hourly forecast
  Future<List<double>> getHourlyForecast(String cityName) async {
    final coords = await getCityCoordinates(cityName);
    final url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=${coords['lat']}&lon=${coords['lon']}&exclude=minutely,daily,alerts,current&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List hours = data['hourly'];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      List<double> temps = [];
      for (final hour in hours) {
        final dt =
            DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000, isUtc: true)
                .toLocal();
        if (dt.year == today.year &&
            dt.month == today.month &&
            dt.day == today.day) {
          temps.add(hour['temp']?.toDouble() ?? 0.0);
        }
      }
      return temps;
    } else {
      throw Exception('Failed to load hourly weather data');
    }
  }
}
