import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/constants/constants.dart';

import '../cubits/cubits.dart';
import '../models/models.dart';

class TallyCountersOverViewPage extends StatelessWidget {
  final List<TallyCounter> tallyCounters;

  const TallyCountersOverViewPage({
    Key? key,
    required this.tallyCounters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      //TODO
      return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return Container();
          },
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Tally Counters'),
        trailing: IconButton(
            iconSize: SizeConstants.normal,
            icon: const FaIcon(FontAwesomeIcons.plus),
            color: Colors.black.withOpacity(0.4),
            onPressed: () {
              BlocProvider.of<TallyCounterCubit>(context).addCounter();
            }),
      ),
      child: BlocBuilder<TallyCounterCubit, TallyCounterState>(
        builder: (context, state) {
          return ListView(
            children: _buildTallyCounterItems(),
          );
        },
      ),
    );
  }

  List<Widget> _buildTallyCounterItems() {
    List<Widget> items = [];
    for (var i = 0; i < tallyCounters.length; i++) {
      items.add(_TallyCounterItem(
        tallyCounter: tallyCounters[i],
      ));
      if (i != tallyCounters.length - 1) {
        items.add(const Divider(
          thickness: 1.5,
        ));
      }
    }
    return items;
  }
}

class _TallyCounterItem extends StatelessWidget {
  final TallyCounter tallyCounter;

  const _TallyCounterItem({
    Key? key,
    required this.tallyCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(SizeConstants.large),
          child: Center(
              child: Text(
            '${tallyCounter.count}',
            style: const TextStyle(fontSize: 25),
          )),
        ),
        onTap: () {
          BlocProvider.of<TallyCounterCubit>(context).switchCounter(tallyCounter);
          PageConstants.pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 250),
            curve: Curves.linear,
          );
        });
  }
}
