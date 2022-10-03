import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'app_header.dart';
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
              const AppHeader(
                title: 'Tally Counter',
                actions: [
                  _AddTallyCounterButton(),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.tallyCounters.length,
                  (BuildContext context, int index) {
                    return _buildTallyCounterListItem(context, index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTallyCounterListItem(BuildContext context, int index) {
    return Column(
      children: [
        TallyCounterItem(tallyCounter: tallyCounters[index]),
        if (index != tallyCounters.length - 1)
          Divider(
            thickness: 1.5,
            height: 0,
            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
          ),
      ],
    );
  }
}

class _AddTallyCounterButton extends StatelessWidget {
  const _AddTallyCounterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: SizeConstants.normalSmaller,
        horizontal: SizeConstants.normal,
      ),
      child: TallyCounterIconButton(
          icon: const FaIcon(FontAwesomeIcons.plus),
          action: () {
            BlocProvider.of<TallyCounterCubit>(context).addCounter();
          }),
    );
  }
}
