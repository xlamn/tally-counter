import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TallyCounterButton extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;

  const TallyCounterButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        SizeConstants.small,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            RadiusConstants.large,
          ),
        ),
      ),
      height: 44,
      width: 44,
      child: IconButton(
        iconSize: SizeConstants.large,
        icon: icon,
        color: Theme.of(context).dialogBackgroundColor,
        onPressed: onPressed,
      ),
    );
  }
}
