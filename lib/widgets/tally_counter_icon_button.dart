import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TallyCounterIconButton extends StatelessWidget {
  final Widget icon;
  final void Function() action;
  final double? iconSize;

  const TallyCounterIconButton({
    super.key,
    required this.icon,
    required this.action,
    this.iconSize = SizeConstants.large,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      icon: icon,
      color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.5),
      onPressed: action,
    );
  }
}
