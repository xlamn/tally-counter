import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../enums/pages.dart';
import '../../extensions/extensions.dart';
import '../../models/models.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/widgets.dart';
import 'tally_counter_item.dart';
import 'tally_counters_settings_page.dart';

class TallyCountersOverViewPage extends StatelessWidget {
  const TallyCountersOverViewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TallyGroupCubit, TallyGroupState>(
      builder: (context, groupState) {
        return Scaffold(
          backgroundColor: _getBackgroundColor(context, groupState),
          body: BlocBuilder<TallyCounterCubit, TallyCounterState>(
            builder: (context, counterState) {
              final tallyCounters = BlocProvider.of<TallyCounterCubit>(context).getCountersFromGroup();

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstants.normal,
                    ),
                    sliver: SliverAppBar(
                      title: _getTitle(context),
                      toolbarHeight: HeightConstants.headerHeight,
                      leading: _ViewTallyGroupsButton(color: _getHeaderColor(context, groupState)),
                      backgroundColor: _getBackgroundColor(context, groupState),
                      actions: [
                        if (BlocProvider.of<TallyGroupCubit>(context).getSelectedGroup() != null)
                          TallyCounterIconButton(
                            icon: FaIcon(FontAwesomeIcons.circleInfo, color: _getHeaderColor(context, groupState)),
                            action: () => _showSettings(context),
                          ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: tallyCounters.length,
                      (BuildContext context, int index) {
                        return _buildTallyCounterListItem(context, index, tallyCounters);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingAddButton(
            onPressed: () => BlocProvider.of<TallyCounterCubit>(context).addCounter(),
          ),
        );
      },
    );
  }

  Color? _getBackgroundColor(BuildContext context, TallyGroupState state) {
    if (state.selected != null && state.tallyGroups[state.selected!].color != null) {
      return state.tallyGroups[state.selected!].color;
    } else {
      return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  Color? _getHeaderColor(BuildContext context, TallyGroupState state) {
    if (state.selected != null && state.tallyGroups[state.selected!].color != null) {
      return context.isDarkMode ? null : Colors.white;
    } else {
      return null;
    }
  }

  Widget _getTitle(BuildContext context) {
    return Center(
      child: BlocBuilder<TallyGroupCubit, TallyGroupState>(
        builder: (context, state) {
          final text = state.selected != null ? state.tallyGroups[state.selected!].title : "";
          return Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _getHeaderColor(context, state),
            ),
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
          ),
      ],
    );
  }

  Future<void> _showSettings(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            RadiusConstants.large,
          ),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: ((context) {
        return Wrap(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const TallyCountersSettingsPage(),
            ),
          ],
        );
      }),
    ).then((value) {
      if (value == null) _updateGroup(context);
    });
  }

  void _updateGroup(BuildContext context) {
    BlocProvider.of<TallyCounterCubit>(context).changeGroupFromCounters(
      PageConstants.groupTitleController.text.isNotEmpty
          ? PageConstants.groupTitleController.text
          : BlocProvider.of<TallyGroupCubit>(context).getSelectedGroup()!.title,
      PageConstants.groupColorController.value,
    );
  }
}

class _ViewTallyGroupsButton extends StatelessWidget {

  final Color? color;
  
  const _ViewTallyGroupsButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.normalSmaller,
      ),
      child: TallyCounterIconButton(
        icon: FaIcon(FontAwesomeIcons.grip, color: color),
        action: () => _onTap(context),
      ),
    );
  }

  void _onTap(BuildContext context) {
    PageConstants.pageController.animateToPage(
      Pages.groupsOverviewPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
