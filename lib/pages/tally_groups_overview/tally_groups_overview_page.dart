import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/widgets/input_dialog.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../extensions/extensions.dart';
import '../../models/models.dart';
import '../../widgets/tally_counter_icon_button.dart';
import 'tally_group_item.dart';
import 'tally_group_summary_item.dart';

class TallyGroupsOverviewPage extends StatelessWidget {
  const TallyGroupsOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TallyGroupCubit, TallyGroupState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.normal,
                ),
                sliver: SliverAppBar(
                  toolbarHeight: HeightConstants.headerHeight,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: const [_AddTallyGroupButton()],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.tallyGroups.length + 1,
                  (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        children: const [
                          TallyGroupSummaryItem(),
                          _GroupsTitle(),
                        ],
                      );
                    }
                    return _buildTallyGroupListItem(context, index - 1, state.tallyGroups);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTallyGroupListItem(
    BuildContext context,
    int index,
    List<TallyGroup> tallyGroups,
  ) {
    return Column(
      children: [
        TallyGroupItem(tallyGroup: tallyGroups[index]),
        if (index == tallyGroups.length - 1)
          const SizedBox(
            height: SizeConstants.xxLarge,
          )
      ],
    );
  }
}

class _GroupsTitle extends StatelessWidget {
  const _GroupsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: const EdgeInsets.only(
            top: SizeConstants.normal,
            bottom: SizeConstants.xSmall,
            left: SizeConstants.xLarge,
            right: SizeConstants.xLarge,
          ),
          child: Text(
            context.local.groups,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 26,
              letterSpacing: 0.8,
            ),
          )),
    );
  }
}

class _AddTallyGroupButton extends StatelessWidget {
  const _AddTallyGroupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.normalSmaller,
      ),
      child: TallyCounterIconButton(
        icon: const FaIcon(FontAwesomeIcons.plus),
        action: () => showInputDialog(
          context,
          title: context.local.newGroup.toCapitalized(),
          actionText: context.local.create.toCapitalized(),
          action: () => BlocProvider.of<TallyGroupCubit>(context).addGroup(
            title: PageConstants.groupTitleController.text,
          ),
        ),
      ),
    );
  }
}
