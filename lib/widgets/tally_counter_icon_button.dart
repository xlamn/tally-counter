import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TallyCounterIconButton extends StatelessWidget {
  final Widget icon;
  final void Function() action;
  final double? iconSize;

  const TallyCounterIconButton({
    Key? key,
    required this.icon,
    required this.action,
    this.iconSize = SizeConstants.large,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        SizeConstants.small,
      ),
      child: IconButton(
        iconSize: iconSize,
        icon: icon,
        color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
        onPressed: action,
      ),
    );
  }
}
