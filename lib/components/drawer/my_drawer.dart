import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/my_clippers.dart';
import 'package:weather_app/components/drawer/my_drawer_tile.dart';
import 'package:weather_app/pages/location_page.dart';
import 'package:weather_app/pages/notify_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(
      indent: 80,
      color: Theme.of(context).colorScheme.onPrimary,
      thickness: 3,
    );
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          ClipPath(
            clipper: CurveEdgeClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipPath(
                  clipper: CurveEdgeClipper(),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.temperatureHalf,
                            size: 40,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Temperature
                              Text("24",
                                  style: GoogleFonts.rubik(
                                      fontSize: 75,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                              Text(
                                // ignore: prefer_adjacent_string_concatenation
                                "°" + "C",
                                style: GoogleFonts.rubik(
                                    fontSize: 45,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              const SizedBox(width: 25),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          MyDrawerTile(
              icon: FontAwesomeIcons.house,
              title: "Home",
              onTap: () {
                Navigator.pop(context);
              }),
          divider,
          const SizedBox(height: 15),
          MyDrawerTile(
              icon: FontAwesomeIcons.gear, title: "Settings", onTap: () {}),
          divider,
          const SizedBox(height: 15),
          MyDrawerTile(
              icon: FontAwesomeIcons.mapLocationDot,
              title: "Location",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocationPage()));
              }),
          divider,
          const SizedBox(height: 15),
          MyDrawerTile(
              icon: FontAwesomeIcons.solidBell,
              title: "Notifications",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotifyPage()));
              }),
          divider,
        ],
      ),
    );
  }
}
