import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/weather_widgets/animated_temp_widg.dart';
import 'package:weather_app/data/offline_data.dart';
import 'package:weather_app/provider/city_provider.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/theme/gradient_text.dart';

// ignore: must_be_immutable
class MainWeatherCard extends StatefulWidget {
  final double panelPosition;
  double blurValue;

  bool isExpanded = false;
  MainWeatherCard({
    super.key,
    required this.panelPosition,
    required this.blurValue,
  });
  double tempWidgWidth = 135;
  String? currentCity;

  @override
  State<MainWeatherCard> createState() => _MainWeatherCardState();
}

class _MainWeatherCardState extends State<MainWeatherCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentCity = Provider.of<CityProvider>(context).selectedCity;
    if (currentCity != widget.currentCity) {
      widget.currentCity = currentCity;
      fetchTemperature();
    }
  }

  String formattedDate = DateFormat('E, MMM d HH:mm').format(DateTime.now());
  double currentTemperature = 0.0;
  List<dynamic> listOfIcons = [""];

  void fetchTemperature() async {
    final apiService = ApiService('0c2b6512b858613da7c1967c0e4f2e67');

    try {
      Map<String, double> temps = await apiService
          .getCurrentTemperature(widget.currentCity ?? 'Warszawa');

      final forecast =
          await apiService.getHourlyForecast(widget.currentCity ?? 'Warszawa');

      setState(() {
        currentTemperature = temps['temp_main'] ?? 99;
        formattedDate = DateFormat('E, MMM d HH:mm').format(DateTime.now());
        listOfIcons = forecast.map((e) => e['icon']).toList();
      });
    } catch (e) {
      setState(() {
        currentTemperature = 99;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1.0 - (widget.panelPosition * 0.1);
    double offset = -(widget.panelPosition * 10);
    double offsetTopC = -(widget.panelPosition * 5);
    double offsetRightC = -(widget.panelPosition * 10);
    double widgetHeight = MediaQuery.of(context).size.height * 0.25;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: widgetHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            //Predicted Temperature for today
            Positioned(
              bottom: 10 + (widget.panelPosition * 110),
              left: 2 + (widget.panelPosition * 190),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: 50,
                width: widget.tempWidgWidth,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(40),
                        width: 2),
                    color:
                        Theme.of(context).colorScheme.onPrimary.withAlpha(30),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AnimatedTempWidget()),
              ),
            ),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.37,
                right: 8,
                bottom: 20 + widget.panelPosition * 60,
                child: RotatedBox(
                    quarterTurns: 0,
                    child: Transform.rotate(
                      angle: 0,
                      child: Row(
                        children: [
                          Icon(
                            Descriptions.getWeatherIcon(
                                Descriptions.getWeatherdescription(
                                    listOfIcons[0],
                                    listOfIcons[listOfIcons.length - 1])),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 165,
                            child: Text(
                                Descriptions.getWeatherdescription(
                                    listOfIcons[0],
                                    listOfIcons[listOfIcons.length - 1]),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ))),

            //Blur effect
            if (widget.blurValue > 0)
              Positioned(
                top: 0,
                left: 0,
                height: 250,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blurValue,
                    sigmaY: widget.blurValue,
                  ),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),

            //Date Time
            Positioned(
              top: 2,
              left: 2,
              child: Text(
                formattedDate,
                style: GoogleFonts.lato(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),

            //Main Temperature
            Positioned(
              top: 5 + offset,
              left: 2,
              child: Transform.scale(
                scale: scale,
                child: IgnorePointer(
                  child: GradientText(
                    text: currentTemperature.toStringAsFixed(0),
                    fontSize: 110,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    applyHeightBehaviors: false,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10 + offsetTopC,
              left: 140 + offsetRightC,
              child: Transform.scale(
                scale: scale,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GradientText(
                      text: "${"°"}C",
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      applyHeightBehaviors: true,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
