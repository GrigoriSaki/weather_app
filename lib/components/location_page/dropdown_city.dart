import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weather_app/services/firestore.dart';

// ignore: must_be_immutable
class MyDropdownCity extends StatefulWidget {
  MyDropdownCity({super.key, required this.selectedCountry});
  String selectedCountry;

  String selectedItem = "";
  late Future<List<String>> citiesFuture;

  @override
  State<MyDropdownCity> createState() => _MyDropdownCityState();
}

class _MyDropdownCityState extends State<MyDropdownCity> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCities();
  }

  @override
  void didUpdateWidget(covariant MyDropdownCity oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCountry != widget.selectedCountry) {
      fetchCities();
    }
  }

  void fetchCities() {
    widget.citiesFuture =
        FirestoreService().getCityNames(widget.selectedCountry).then((cities) {
      if (cities.isNotEmpty) {
        widget.selectedItem = cities.first; // Ustawiamy pierwsze miasto
      }
      if (mounted) {
        setState(() {});
      }
      return cities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return // Dropdown for country selection
        FutureBuilder(
            future: widget.citiesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                );
              } else if (snapshot.hasData) {
                return DropdownSearch<String>(
                  // This is what is displayed on the list
                  items: (filter, InfiniteScrollProps) async {
                    return widget.citiesFuture;
                  },

                  //control of displayed item
                  dropdownBuilder: (context, selectItem) {
                    return Text(selectItem ?? "",
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
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          label: Text("City",
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface)))),
                );
              } else {
                return Text("Cities not founded");
              }
            });
  }
}
