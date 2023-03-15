import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/enums/enums.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../extensions/extensions.dart';
import '../../helper/helper.dart';
import '../../widgets/widgets.dart';

class TallyCounterSettingsPage extends StatelessWidget {
  const TallyCounterSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TallyCounterCubit, TallyCounterState>(
      builder: (context, state) {
        _initializeControllerValues(state);

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SizeConstants.large,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: SizeConstants.large,
                ),
                FormTextField(
                  tallyCounter: state.tallyCounters[state.selected],
                  title: context.local.title.toCapitalized(),
                  textController: PageConstants.titleController,
                ),
                FormValueField(
                  tallyCounter: state.tallyCounters[state.selected],
                  title: context.local.value.toCapitalized(),
                  valueController: PageConstants.countController,
                ),
                FormValueField(
                  tallyCounter: state.tallyCounters[state.selected],
                  title: context.local.steps.toCapitalized(),
                  valueController: PageConstants.stepController,
                ),
                FormDropdownField(
                  tallyCounter: state.tallyCounters[state.selected],
                  title: context.local.group,
                  dropdownItems: BlocProvider.of<TallyGroupCubit>(context).state.tallyGroups,
                  controller: PageConstants.groupController,
                ),
                _DeleteButton(state: state),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initializeControllerValues(TallyCounterState state) {
    PageConstants.titleController.value = TextEditingValue(
      text: state.tallyCounters[state.selected].title,
    );

    //TODO: Cursor isn't consistent
    PageConstants.countController.value = TextEditingValue(
      text: '${state.tallyCounters[state.selected].count}',
    );

    PageConstants.stepController.value = TextEditingValue(
      text: '${state.tallyCounters[state.selected].step}',
    );

    PageConstants.groupController = TallyGroupController(
      value: state.tallyCounters[state.selected].group,
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final TallyCounterState state;

  const _DeleteButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (state.tallyCounters.length > 1) ? () => _onDelete(context) : null,
      child: Container(
        margin: const EdgeInsets.all(SizeConstants.large),
        padding: const EdgeInsets.symmetric(
          vertical: SizeConstants.normal,
          horizontal: SizeConstants.large,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          context.local.delete.toCapitalized().toCapitalized(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  void _onDelete(BuildContext context) {
    BlocProvider.of<TallyCounterCubit>(context).removeCounter();
    Navigator.pop(context, "isDeleted");
    PageConstants.pageController.animateToPage(
      Pages.tallyCountersOverviewPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
