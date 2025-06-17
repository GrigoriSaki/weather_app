import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/services/firestore.dart';

class MyDropDown extends StatefulWidget {
  MyDropDown({super.key});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String? selectedCity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSelectedCity();
  }

  Future<void> _loadSelectedCity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCity = prefs.getString('selected_city') ?? 'Warszawa';
    });
  }

  Future<void> _saveSelectedCity(String? city) async {
    final prefs = await SharedPreferences.getInstance();
    if (city != null) {
      await prefs.setString('selected_city', city);
    }
  }

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      asyncItems: (String filter) async {
        var cities = await firestoreService.getCities();
        return cities
            .map((city) => city['name'] as String)
            .where((name) => name.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      },
      onChanged: (city) {
        setState(() {
          selectedCity = city as String?;
        });
        _saveSelectedCity(city as String?);
      },
      selectedItem: selectedCity,
      dropdownBuilder: (context, selectedItem) => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          selectedItem.toString(),
          style: TextStyle(fontSize: 19),
        ),
      ),
      popupProps: PopupProps.menu(
        itemBuilder: (context, item, isSelected) => Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 5),
          child: Text(
            item.toString(),
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
