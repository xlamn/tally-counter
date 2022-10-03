import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/widgets/widgets.dart';

import '../../cubits/cubits.dart';
import '../../models/models.dart';
import 'tally_counter_item.dart';

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
                  TallyCounterIconButton(
                      icon: const FaIcon(FontAwesomeIcons.plus),
                      action: () {
                        BlocProvider.of<TallyCounterCubit>(context).addCounter();
                      })
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
        TallyCounterItem(tallyCounter: tallyCounters[index]),
        if (index != tallyCounters.length - 1)
          const Divider(
            thickness: 1.5,
            height: 0,
          ),
      ],
    );
  }
}
