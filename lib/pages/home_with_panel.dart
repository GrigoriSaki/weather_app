import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather_app/components/drawer/my_drawer.dart';
import 'package:weather_app/components/slide_up_content/panel_content.dart';
import 'package:weather_app/pages/home_page.dart';

class HomeWithPanel extends StatefulWidget {
  const HomeWithPanel({super.key});

  @override
  State<HomeWithPanel> createState() => _HomeWithPanelState();
}

class _HomeWithPanelState extends State<HomeWithPanel> {
  final PanelController _panelController = PanelController();
  double _panelPosition = 0.0;
  double _blurValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: SlidingUpPanel(
        controller: _panelController,
        color: Colors.transparent,
        minHeight: 75 + MediaQuery.of(context).size.height / 3,
        maxHeight: 50 + MediaQuery.of(context).size.height * 2 / 3,
        panel: PanelContent(
          panelPosition: _panelPosition,
        ),
        onPanelSlide: (position) {
          setState(() {
            _panelPosition = position;
            if (position > 0.01 && position < 1) {
              _blurValue = position * 10;
            } else {
              _blurValue = 0;
            }
          });
        },
        body: HomePage(
          panelPosition: _panelPosition,
          blurValue: _blurValue,
        ),
      ),
    );
  }
}
