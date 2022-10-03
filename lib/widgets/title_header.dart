import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TitleHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const TitleHeader({
    Key? key,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.xLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28.0,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
