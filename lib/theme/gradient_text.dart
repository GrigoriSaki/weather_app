import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      required this.applyHeightBehaviors});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final bool applyHeightBehaviors;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.onPrimary.withAlpha(70),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: GoogleFonts.rubik(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        textHeightBehavior:
            TextHeightBehavior(applyHeightToFirstAscent: applyHeightBehaviors),
      ),
    );
  }
}
