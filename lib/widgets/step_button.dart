import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';

class StepButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final void Function()? onPressed;

  const StepButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.xxSmall,
      ),
      margin: const EdgeInsets.all(SizeConstants.xSmall),
      decoration: BoxDecoration(
        color: color.withValues(alpha: context.isDarkMode ? 0.3 : 0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            RadiusConstants.large,
          ),
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
