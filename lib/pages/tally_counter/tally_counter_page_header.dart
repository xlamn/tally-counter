import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/enums/enums.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'tally_counter_settings_page.dart';

class TallyCounterPageHeader extends StatelessWidget {
  final TallyCounter tallyCounter;

  const TallyCounterPageHeader({
    super.key,
    required this.tallyCounter,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: HeightConstants.headerHeight,
          padding: const EdgeInsets.symmetric(
            vertical: SizeConstants.small,
            horizontal: SizeConstants.normal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TallyCounterIconButton(
                icon: const FaIcon(FontAwesomeIcons.bars),
                action: () => _showTallyCountersOverview(context),
              ),
              _HeaderTitle(tallyCounter: tallyCounter),
              TallyCounterIconButton(
                icon: const FaIcon(FontAwesomeIcons.circleInfo),
                action: () async => await _showSettings(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTallyCountersOverview(BuildContext context) {
    PageConstants.pageController.animateToPage(
      Pages.tallyCountersOverviewPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
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
              child: const TallyCounterSettingsPage(),
            ),
          ],
        );
      }),
    ).then((value) {
      if (value == null) _updateCounter(context);
    });
  }

  void _updateCounter(BuildContext context) {
    BlocProvider.of<TallyCounterCubit>(context).updateCounter(
      title: PageConstants.titleController.text,
      count: PageConstants.countController.value.text.isNotEmpty
          ? int.parse(
              PageConstants.countController.value.text,
            )
          : null,
      step: PageConstants.stepController.value.text.isNotEmpty
          ? int.parse(
              PageConstants.stepController.value.text,
            )
          : null,
      group: PageConstants.groupController.value,
      forceOverrideGroup: true,
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  final TallyCounter tallyCounter;

  const _HeaderTitle({required this.tallyCounter});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (tallyCounter.title.isNotEmpty)
          Text(
            tallyCounter.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headlineMedium!.color!.withValues(alpha: 0.8),
            ),
          ),
        if (tallyCounter.group?.title != null)
          Text(
            tallyCounter.group!.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineSmall!.color!.withValues(alpha: 0.8),
            ),
          )
      ],
    );
  }
}
