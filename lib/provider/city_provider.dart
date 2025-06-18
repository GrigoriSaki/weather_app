import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityProvider extends ChangeNotifier {
  String _selectedCity = "Warszawa";

  String get selectedCity => _selectedCity;

  void setSelectedCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final city = prefs.getString('selected_city');
    if (city != null) {
      _selectedCity = city;
      notifyListeners();
    }
  }
}
