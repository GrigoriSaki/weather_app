import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyDropdownSearch extends StatelessWidget {
  MyDropdownSearch(
      {super.key,
      required this.selectedItem,
      required this.countryOrCity,
      required this.countriesOrCities});
  String selectedItem;
  String countryOrCity;
  List<String> countriesOrCities;
  @override
  Widget build(BuildContext context) {
    return // Dropdown for country selection
        DropdownSearch<String>(
      // This is what is displayed on the list
      items: (filter, InfiniteScrollProps) async {
        return countriesOrCities;
      },

      //control of displayed item
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem ?? "",
            style: GoogleFonts.lato(
                fontSize: 18, color: Theme.of(context).colorScheme.onSurface));
      },

      //this displays the form
      enabled: true,

      //what is displayed after selecting the item
      selectedItem: selectedItem,

      //decoration of the form
      decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Theme.of(context).colorScheme.primary)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.primary)),
              label: Text(countryOrCity,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface)))),
    );
  }
}
