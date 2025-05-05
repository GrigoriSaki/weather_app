import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/services/choose_location_service.dart';

class LocationPage extends StatefulWidget {
  LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  ChooseLocation chooseLocation = ChooseLocation();

  String selectedCity = "";
  String selectedCountry = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Text(
                      "Choose Your Location:",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(height: 20),

                    // Dropdown for country selection
                    DropdownSearch<String>(
                      // This is what is displayed on the list
                      items: (filter, InfiniteScrollProps) async {
                        return chooseLocation.countries;
                      },

                      //control of displayed item
                      dropdownBuilder: (context, selectedItem) {
                        return Text(selectedItem ?? "",
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onSurface));
                      },

                      //this displays the form
                      enabled: true,

                      //what is displayed after selecting the item
                      selectedItem: selectedCountry,

                      //decoration of the form
                      decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              label: Text("Select country",
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)))),
                    ),
                    const SizedBox(height: 20),
                    // Dropdown for country selection
                    DropdownSearch<String>(
                      // This is what is displayed on the list
                      items: (filter, InfiniteScrollProps) async {
                        return chooseLocation.cities;
                      },

                      //control of displayed item
                      dropdownBuilder: (context, selectedItem) {
                        return Text(selectedItem ?? "",
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onSurface));
                      },

                      //this displays the form
                      enabled: true,

                      //what is displayed after selecting the item
                      selectedItem: selectedCity,

                      //decoration of the form
                      decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              label: Text("Select city",
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
