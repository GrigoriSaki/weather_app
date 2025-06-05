import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/firestore.dart';

class MyDropDown extends StatelessWidget {
  MyDropDown({super.key});

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      asyncItems: (String filter) async {
        return firestoreService.getCities().then(
              (cities) => cities
                  .where((city) =>
                      city['name'].toLowerCase().contains(filter.toLowerCase()))
                  .toList(),
            );
      },
    );
  }
}
