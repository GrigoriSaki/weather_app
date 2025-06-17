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
  String _displayedText = "Tommorow";
  bool _hasUpdatedText = false;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: SlidingUpPanel(
        controller: _panelController,
        color: Colors.transparent,
        minHeight: MediaQuery.of(context).size.height / 2.5,
        maxHeight: MediaQuery.of(context).size.height / 1.4,
        panel: PanelContent(
          scrollController: _scrollController,
          dsiplayedText: _displayedText,
          panelPosition: _panelPosition,
        ),
        onPanelSlide: (position) {
          setState(() {
            _panelPosition = position;

            if (position == 0) {
              _scrollController.jumpTo(0);
            }

            _panelPosition = position;
            if (position > 0.01 && position < 1) {
              _blurValue = position * 10;
            } else {
              _blurValue = 0;
            }
            if (position >= 1.0 && !_hasUpdatedText) {
              _hasUpdatedText = true;
              Future.delayed(Duration(milliseconds: 100), () {
                setState(() {
                  _displayedText = "Weekly";
                });
              });
            }

            if (position <= 0.0 && _hasUpdatedText) {
              _hasUpdatedText = false;
              Future.delayed(Duration(milliseconds: 100), () {
                setState(() {
                  _displayedText = "Tomorrow";
                });
              });
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
