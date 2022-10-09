import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../pages.dart';

class TopButtonRow extends StatelessWidget {
  final TallyCounter tallyCounter;

  const TopButtonRow({
    Key? key,
    required this.tallyCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: SizeConstants.small,
            horizontal: SizeConstants.normal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TallyCounterIconButton(
                icon: const FaIcon(FontAwesomeIcons.bars),
                action: () => _showOverview(context),
              ),
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

  void _showOverview(BuildContext context) {
    PageConstants.pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }

  Future<void> _showSettings(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: ((context) => const TallyCounterSettingsPage()),
    ).whenComplete(() => _updateCounter(context));
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
    );
  }
}
