import 'package:flutter/material.dart';

class TabCurvedClipper extends CustomClipper<Path> {
    @override
    Path getClip(Size size) {
      double height = size.height;
      double width = size.width;
      final path = Path();
      path.lineTo(width-225, 0); // Top-right corner
      path.quadraticBezierTo(
          width, height/2, width-225, height); // Curve control point
      path.lineTo(0, height); // Bottom-left corner
      path.close();
      return path;
    }

    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
      return false;
    }
  }