import 'package:flutter/material.dart';

class CurveEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    const double cornerRadius = 20.0;

    path.moveTo(0, 0);
    path.lineTo(0, size.height - cornerRadius);
    path.quadraticBezierTo(
      0,
      size.height,
      cornerRadius,
      size.height,
    );
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 30,
      size.width - cornerRadius,
      size.height,
    );
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - cornerRadius,
    );
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TopEdgeCurved extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    const double cornerRadius = 35.0;

    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);
    path.quadraticBezierTo(
      size.width / 2,
      25,
      size.width - cornerRadius,
      0,
    );
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
