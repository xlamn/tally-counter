import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'tally_counter_item.dart';

class TallyCountersOverViewPage extends StatelessWidget {
  const TallyCountersOverViewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TallyCounterCubit, TallyCounterState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.normal,
                ),
                sliver: SliverAppBar(
                  toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                  leading: const _GroupCounterButton(),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: const [
                    _AddTallyCounterButton(),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.tallyCounters.length,
                  (BuildContext context, int index) {
                    return _buildTallyCounterListItem(context, index, state.tallyCounters);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTallyCounterListItem(
    BuildContext context,
    int index,
    List<TallyCounter> tallyCounters,
  ) {
    return Column(
      children: [
        TallyCounterItem(tallyCounter: tallyCounters[index]),
        if (index == tallyCounters.length - 1)
          const SizedBox(
            height: SizeConstants.xxLarge,
          )
      ],
    );
  }
}

class _GroupCounterButton extends StatelessWidget {
  const _GroupCounterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.normalSmaller,
      ),
      child: TallyCounterIconButton(
        icon: const FaIcon(FontAwesomeIcons.qrcode),
        action: () => _onTap(context),
      ),
    );
  }

  void _onTap(BuildContext context) {
    PageConstants.pageController.animateToPage(
      PageConstants.groupsOverviewPage,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}

class _AddTallyCounterButton extends StatelessWidget {
  const _AddTallyCounterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.normalSmaller,
      ),
      child: TallyCounterIconButton(
          icon: const FaIcon(FontAwesomeIcons.plus),
          action: () {
            BlocProvider.of<TallyCounterCubit>(context).addCounter();
          }),
    );
  }
}
