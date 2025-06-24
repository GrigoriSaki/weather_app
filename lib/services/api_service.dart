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
}
