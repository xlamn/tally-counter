import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();
  @override
  Color fromJson(String json) {
    return _getColorFromHex(json);
  }

  @override
  String toJson(Color color) {
    return _getHexFromColor(color);
  }
}

Color _getColorFromHex(String hexColor) {
  hexColor = "FF${hexColor.replaceFirst("#", "")}";
  return Color(int.parse("0x$hexColor"));
}

String _getHexFromColor(Color color) {
  return '#${color.value.toRadixString(16).substring(2)}';
}
