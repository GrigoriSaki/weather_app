import 'package:flutter/material.dart';
import 'package:weather_app/components/my_clippers.dart';

class PanelContent extends StatelessWidget {
  const PanelContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopEdgeCurved(),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 3,
              endIndent: 175,
              indent: 175,
            ),
          ],
        ),
      ),
    );
  }
}
