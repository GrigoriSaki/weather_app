import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({super.key});
  String currentLocation = "Warszawa";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25, bottom: 8),
      child: Row(
        children: [
          //Location
          Icon(Icons.location_on_sharp,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
          const SizedBox(width: 3),

          Text(
            "$currentLocation, Polska",
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
