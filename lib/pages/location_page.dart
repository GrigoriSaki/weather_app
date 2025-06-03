import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LocationPage extends StatefulWidget {
  LocationPage({super.key});
  String selectedCountry = "Australia";

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
