import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';

class StepButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final void Function()? onPressed;

  const StepButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.xxSmall,
      ),
      margin: const EdgeInsets.all(SizeConstants.xSmall),
      decoration: BoxDecoration(
        color: color.withOpacity(context.isDarkMode ? 0.1 : 0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: SizeConstants.normal,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
