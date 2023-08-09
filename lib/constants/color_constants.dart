import 'package:flutter/material.dart';

class ColorConstants {
  static final defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: white,
  );
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
  );
}

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Colors.white,
    100: Colors.white,
    200: Colors.white,
    300: Colors.white,
    400: Colors.white,
    500: Colors.white,
    600: Colors.white,
    700: Colors.white,
    800: Colors.white,
    900: Colors.white,
  },
);
