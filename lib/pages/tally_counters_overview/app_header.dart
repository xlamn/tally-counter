import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  const AppHeader({
    Key? key,
    required this.title,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: 150,
      toolbarHeight: 70,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(
          top: SizeConstants.large,
          bottom: SizeConstants.normal,
          right: SizeConstants.xLarge,
          left: SizeConstants.xLarge,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
      ),
      actions: actions,
    );
  }
}
