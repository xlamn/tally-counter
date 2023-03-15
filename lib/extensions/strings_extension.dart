extension StringCasingExtension on String {
  String _toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toCapitalized() => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str._toCapitalized()).join(" ");
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
