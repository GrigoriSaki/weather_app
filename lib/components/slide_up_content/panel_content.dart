import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/my_clippers.dart';
import 'package:weather_app/components/slide_up_content/hourly_forecast.dart';
import 'package:weather_app/components/slide_up_content/forecast_card.dart';
import 'package:weather_app/data/hourly_fore_icons.dart';
import 'package:weather_app/data/offline_data.dart';
import 'package:weather_app/provider/city_provider.dart';
import 'package:weather_app/services/api_service.dart';

// ignore: must_be_immutable
class PanelContent extends StatefulWidget {
  double panelPosition;
  final String dsiplayedText;
  ScrollController scrollController;
  GetHourlyForecastIcon getWeatherIcon = GetHourlyForecastIcon();

  int weekDay = DateTime.now().weekday;

  PanelContent({
    super.key,
    required this.panelPosition,
    required this.dsiplayedText,
    required this.scrollController,
  });

  String? currentCity;

  @override
  State<PanelContent> createState() => _PanelContentState();
}

class _PanelContentState extends State<PanelContent> {
  Descriptions descriptions = Descriptions();
  List<dynamic> listOfTemps = [];
  List<dynamic> listOfHours = [];
  List<dynamic> listOfIcons = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentCity = Provider.of<CityProvider>(context).selectedCity;
    if (currentCity != widget.currentCity) {
      widget.currentCity = currentCity;
    }
    fetchListOfTemps();
  }

  void fetchListOfTemps() async {
    final apiService = ApiService('0c2b6512b858613da7c1967c0e4f2e67');

    try {
      final forecast =
          await apiService.getHourlyForecast(widget.currentCity ?? 'Warszawa');
      setState(() {
        listOfTemps = forecast.map((e) => e['temp']).toList();
        listOfHours = forecast.map((e) => e['hour']).toList();
        listOfIcons = forecast.map((e) => e['icon']).toList();
      });
    } catch (e) {
      setState(() {
        listOfTemps = [
          9,
          9,
          9,
          9,
          9,
          9,
          9,
          9,
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopEdgeCurved(),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 3,
                    endIndent: 150,
                    indent: 150,
                  ),
                  Text("Hourly Forecast",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface)),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 110,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listOfTemps.length,
                          itemBuilder: (context, index) {
                            return HourlyForecast(
                              icon: widget.getWeatherIcon
                                  .giveIcon(listOfIcons[index].toString()),
                              hour: ('${listOfHours[index].toString()}:00'),
                              temperature:
                                  listOfTemps[index].round().toString(),
                            );
                          })),
                  Text(widget.dsiplayedText,
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface)),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                controller: widget.scrollController,
                physics: widget.panelPosition == 0
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 25, right: 25, top: 0),
                    child: ForecastCard(
                      weather_icon:
                          descriptions.icons[(widget.weekDay + index) % 7],
                      day_of_week:
                          descriptions.daysOfWeek[(widget.weekDay + index) % 7],
                      comment: descriptions
                          .descriptions[(widget.weekDay + index) % 7],
                      low_temp:
                          descriptions.lowTemp[(widget.weekDay + index) % 7],
                      high_temp:
                          descriptions.highTemp[(widget.weekDay + index) % 7],
                    ),
                  );
                },
                itemCount: 7,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
