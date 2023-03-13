import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/widgets/input_dialog.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
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
                        children: [
                          const TallyGroupSummaryItem(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.only(
                                  top: SizeConstants.normal,
                                  bottom: SizeConstants.xSmall,
                                  left: SizeConstants.xLarge,
                                  right: SizeConstants.xLarge,
                                ),
                                child: Text(
                                  "Groups".toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: 2),
                                )),
                          ),
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
          title: "New Group",
          actionText: "Create",
          action: () => BlocProvider.of<TallyGroupCubit>(context).addGroup(
            title: PageConstants.groupTitleController.text,
          ),
        ),
      ),
    );
  }
}
