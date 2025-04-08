import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather_app/components/panel_content.dart';
import 'package:weather_app/pages/home_page.dart';

class HomeWithPanel extends StatefulWidget {
  const HomeWithPanel({super.key});

  @override
  State<HomeWithPanel> createState() => _HomeWithPanelState();
}

class _HomeWithPanelState extends State<HomeWithPanel> {
  final PanelController _panelController = PanelController();
  double _panelPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: _panelController,
        color: Colors.transparent,
        minHeight: MediaQuery.of(context).size.height / 3,
        maxHeight: MediaQuery.of(context).size.height * 2 / 3,
        panel: PanelContent(),
        onPanelSlide: (position) {
          setState(() {
            _panelPosition = position;
          });
        },
        body: HomePage(panelPosition: _panelPosition),
      ),
    );
  }
}
