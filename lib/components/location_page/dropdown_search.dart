import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/firestore.dart';

// ignore: must_be_immutable
class MyDropdownSearch extends StatefulWidget {
  MyDropdownSearch({
    super.key,
    required this.selectedItem,
    required this.countryOrCity,
  });
  String selectedItem;
  String countryOrCity;

  @override
  State<MyDropdownSearch> createState() => _MyDropdownSearchState();
}

class _MyDropdownSearchState extends State<MyDropdownSearch> {
  late Future<List<String>> _countriesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countriesFuture = FirestoreService().getCountryNames();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _countriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            );
          } else if (snapshot.hasData) {
            final countries = snapshot.data ?? [];

            return // Dropdown for country selection
                DropdownSearch<String>(
              // This is what is displayed on the list
              items: (filter, InfiniteScrollProps) async {
                return countries;
              },

              //control of displayed item
              dropdownBuilder: (context, selectedItem) {
                return Text(selectedItem ?? "",
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface));
              },

              //this displays the form
              enabled: true,

              //what is displayed after selecting the item
              selectedItem: widget.selectedItem,

              //decoration of the form
              decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.primary)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary)),
                      label: Text(widget.countryOrCity,
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color:
                                  Theme.of(context).colorScheme.onSurface)))),
            );
          } else {
            return Text('No countries found');
          }
        });
  }
}
