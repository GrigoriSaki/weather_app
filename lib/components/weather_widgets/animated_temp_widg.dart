import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/two_temp_widg.dart';
import 'package:weather_app/provider/city_provider.dart';
import 'package:weather_app/services/api_service.dart';

class AnimatedTempWidget extends StatefulWidget {
  const AnimatedTempWidget({super.key, required this.isExpanded});

  final bool isExpanded;

  @override
  State<AnimatedTempWidget> createState() => _AnimatedTempWidgetState();
}

class _AnimatedTempWidgetState extends State<AnimatedTempWidget> {
  String? currentCity;
  String? minTemperature;
  String? maxTemperature;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provideCity = Provider.of<CityProvider>(context).selectedCity;
    if (provideCity != currentCity) {
      currentCity = provideCity;
      fetchTemperature();
    }
  }

  void fetchTemperature() async {
    final apiService = ApiService('0c2b6512b858613da7c1967c0e4f2e67');

    try {
      Map<String, double> temps =
          await apiService.getCurrentTemperature(currentCity ?? 'Warszawa');

      setState(() {
        minTemperature = temps['temp_min']!.toStringAsFixed(0);
        maxTemperature = temps['temp_max']!.toStringAsFixed(0);
      });
    } catch (e) {
      setState(() {
        minTemperature = "99";
        maxTemperature = "99";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Today",
              style: GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                TwoTempWidg(
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  lowTemp: minTemperature ?? "12",
                  highTemp: maxTemperature ?? "18",
                  iconColor:
                      Theme.of(context).colorScheme.onPrimary.withAlpha(200),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
        widget.isExpanded
            ? RotatedBox(
                quarterTurns: 3,
                child: Divider(
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(50),
                  thickness: 3,
                  endIndent: 5,
                  indent: 5,
                ),
              )
            : SizedBox(),
        widget.isExpanded
            ? Column(
                children: [
                  Text(
                    "Tomorrow",
                    style: GoogleFonts.lato(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      TwoTempWidg(
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        lowTemp: "18",
                        highTemp: "25",
                        iconColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(200),
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }
}
