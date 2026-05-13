// lib/providers/temperature_provider.dart
// ✅ FILE BARU - Dipindah dari main.dart ke file sendiri

import 'package:flutter/material.dart';

class TemperatureProvider extends ChangeNotifier {
  String _fromUnit = "Celsius";
  String _toUnit = "Fahrenheit";
  double _result = 0.0;
  String _inputText = "";

  // Getters
  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;
  double get result => _result;

  void setFromUnit(String value) {
    _fromUnit = value;
    notifyListeners();
  }

  void setToUnit(String value) {
    _toUnit = value;
    notifyListeners();
  }

  void setInputText(String value) {
    _inputText = value;
  }

  void convertTemperature() {
    double input = double.tryParse(_inputText) ?? 0;
    double tempInCelsius;

    if (_fromUnit == "Celsius") {
      tempInCelsius = input;
    } else if (_fromUnit == "Fahrenheit") {
      tempInCelsius = (input - 32) * 5 / 9;
    } else {
      tempInCelsius = input - 273.15;
    }

    if (_toUnit == "Celsius") {
      _result = tempInCelsius;
    } else if (_toUnit == "Fahrenheit") {
      _result = (tempInCelsius * 9 / 5) + 32;
    } else {
      _result = tempInCelsius + 273.15;
    }

    notifyListeners();
  }
}