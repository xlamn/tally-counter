import 'package:flutter/material.dart';

class ColorController extends ChangeNotifier {
  ColorController({this.value});
  Color? value;

  void setValue(Color? value) {
    this.value = value;
    notifyListeners();
  }
}
