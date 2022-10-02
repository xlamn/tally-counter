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
    return Scaffold(
      body: BlocBuilder<TallyCounterCubit, TallyCounterState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: const Text('Easy Tally Counter'),
                actions: [
                  Container(
                    padding: const EdgeInsets.all(SizeConstants.small),
                    child: IconButton(
                        iconSize: SizeConstants.normal,
                        icon: const FaIcon(FontAwesomeIcons.plus),
                        color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
                        onPressed: () {
                          BlocProvider.of<TallyCounterCubit>(context).addCounter();
                        }),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.tallyCounters.length,
                  (BuildContext context, int index) {
                    return _buildTallyCounterListItem(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTallyCounterListItem(int index) {
    return Column(
      children: [
        _TallyCounterItem(tallyCounter: tallyCounters[index]),
        if (index != tallyCounters.length - 1)
          const Divider(
            thickness: 1.5,
            height: 0,
          ),
      ],
    );
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
          padding: const EdgeInsets.all(SizeConstants.xLarge),
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
