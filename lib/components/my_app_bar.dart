import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/location_page.dart';
import 'package:weather_app/provider/city_provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<CityProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 25, top: 25, bottom: 8),
      child: Row(
        children: [
          //Location

          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LocationPage()));
            },
            icon: Icon(Icons.location_on_sharp,
                size: 30, color: Theme.of(context).colorScheme.onPrimary),
          ),

          const SizedBox(width: 3),

          Text(
            "${currentLocation.selectedCity}, Polska",
            style: GoogleFonts.lato(
                fontSize: 23, color: Theme.of(context).colorScheme.onPrimary),
          ),

          //Menu Button
          const Spacer(),
          Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: FaIcon(FontAwesomeIcons.barsStaggered),
                  color: Theme.of(context).colorScheme.onPrimary))
        ],
      ),
    );
  }
}
