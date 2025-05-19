import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/firestore.dart';

// ignore: must_be_immutable
class MyDropdownSearch extends StatefulWidget {
  MyDropdownSearch({
    super.key,
    required this.onCountryChanged,
  });
  String selectedItem = "";
  String selectedCountry = "Australia";
  final void Function(String)? onCountryChanged;
  Future<List<String>> countriesFuture = FirestoreService().getCountryNames();
  @override
  State<MyDropdownSearch> createState() => _MyDropdownSearchState();
}

class _MyDropdownSearchState extends State<MyDropdownSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.countriesFuture =
        FirestoreService().getCountryNames().then((countries) {
      if (countries.isNotEmpty) {
        widget.selectedItem = countries.first; // Ustawiamy pierwszy kraj
      }
      return countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Dropdown for country selection
        FutureBuilder(
            future: widget.countriesFuture,
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
                  onChanged: (value) {
                    setState(() {
                      widget.selectedCountry = value!;
                    });

                    // Dodaj to:
                    if (widget.onCountryChanged != null) {
                      widget.onCountryChanged!(value!);
                    }
                  },
                  // This is what is displayed on the list
                  items: (filter, InfiniteScrollProps) async {
                    return widget.countriesFuture;
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
                          label: Text("Country",
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface)))),
                );
              } else {
                return Text("Countries not founded");
              }
            });
  }
}
