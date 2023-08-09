import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/size_constants.dart';

class FloatingAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingAddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        SizeConstants.normalLarger,
      ),
      height: 120.0,
      width: 120.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: onPressed,
          child: const FaIcon(FontAwesomeIcons.plus),
        ),
      ),
    );
  }
}
