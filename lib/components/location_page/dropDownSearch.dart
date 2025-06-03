import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      asyncItems: (String filter) async {
        return [];
      },
    );
  }
}
