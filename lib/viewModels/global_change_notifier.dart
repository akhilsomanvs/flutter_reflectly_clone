import 'package:flutter/material.dart';

class GlobalChangeNotifier extends ChangeNotifier {
  double animValue;
  Gradient previousTheme = LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFFFECEA6), Color(0xFFFF9E9D)]);
  Gradient currentThemeGradient = LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFFFECEA6), Color(0xFFFF9E9D)]);

  setAnimValue(double value, {bool shouldNotify = false}) {
    this.animValue = value;
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setCurrentThemeGradient(Gradient gradient) {
    previousTheme = currentThemeGradient;
    currentThemeGradient = gradient;
    notifyListeners();
  }

  void setCurrentToPreviousTheme() {
    previousTheme = currentThemeGradient;
    notifyListeners();
  }
}
