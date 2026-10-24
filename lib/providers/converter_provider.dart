import 'package:flutter/material.dart';

class ConverterProvider extends ChangeNotifier {
  String _category = 'Length';
  String _fromUnit = 'Meter';
  String _toUnit = 'Kilometer';
  String _inputValue = '25';

  String get category => _category;
  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;

  List<String> get categories => ['Length', 'Weight', 'Temperature'];

  List<String> get units {
    if (_category == 'Length') {
      return ['Meter', 'Kilometer'];
    } else if (_category == 'Weight') {
      return ['Gram', 'Kilogram'];
    } else {
      return ['Celsius', 'Fahrenheit'];
    }
  }

  void changeCategory(String category) {
    if (_category == category) return;

    _category = category;
    _fromUnit = units[0];
    _toUnit = units[1];
    notifyListeners();
  }

  void changeFromUnit(String? unit) {
    if (unit == null) return;
    _fromUnit = unit;
    notifyListeners();
  }

  void changeToUnit(String? unit) {
    if (unit == null) return;
    _toUnit = unit;
    notifyListeners();
  }

  void swapUnits() {
    String previousFromUnit = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = previousFromUnit;
    notifyListeners();
  }

  void changeInput(String value) {
    _inputValue = value;
    notifyListeners();
  }

  double? get result {
    double? value = double.tryParse(_inputValue.trim());
    if (value == null || !value.isFinite) return null;

    if (_fromUnit == _toUnit) return value;

    if (_category == 'Length') {
      if (_fromUnit == 'Meter') {
        return value / 1000;
      } else {
        return value * 1000;
      }
    } else if (_category == 'Weight') {
      if (_fromUnit == 'Gram') {
        return value / 1000;
      } else {
        return value * 1000;
      }
    } else {
      if (_fromUnit == 'Celsius') {
        return (value * 9 / 5) + 32;
      } else {
        return (value - 32) * 5 / 9;
      }
    }
  }

  String get resultText {
    double? convertedValue = result;
    if (convertedValue == null || !convertedValue.isFinite) {
      return '—';
    }

    // Remove extra zeros after the decimal point.
    String number = convertedValue.toStringAsFixed(6);
    if (number.contains('.')) {
      while (number.endsWith('0')) {
        number = number.substring(0, number.length - 1);
      }
      if (number.endsWith('.')) {
        number = number.substring(0, number.length - 1);
      }
    }

    // Avoid displaying -0 for very small negative values.
    if (number == '-0') number = '0';

    String symbol = '';
    if (_toUnit == 'Meter') {
      symbol = 'm';
    } else if (_toUnit == 'Kilometer') {
      symbol = 'km';
    } else if (_toUnit == 'Gram') {
      symbol = 'g';
    } else if (_toUnit == 'Kilogram') {
      symbol = 'kg';
    } else if (_toUnit == 'Celsius') {
      symbol = '°C';
    } else if (_toUnit == 'Fahrenheit') {
      symbol = '°F';
    }

    return '$number $symbol';
  }
}
