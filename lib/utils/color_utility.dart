import 'package:flutter/material.dart';

class ColorUtility {
  static Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'violet':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
