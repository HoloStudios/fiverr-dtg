import 'package:flutter/material.dart';

class Responsivetext {
  static double getSize(BuildContext context, double size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth/400;

    return (size * scaleFactor).clamp(size * 0.8, size * 1.4);
  }
}