import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/enums/enums.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../extensions/extensions.dart';
import '../../widgets/widgets.dart';

class TallyCountersSettingsPage extends StatelessWidget {
  const TallyCountersSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TallyGroupCubit, TallyGroupState>(
      builder: (context, state) {
        _initializeControllerValues(context, state);

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
                  title: context.local.title.toCapitalized(),
                  textController: PageConstants.titleController,
                ),
                _DeleteButton(state: state),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initializeControllerValues(context, TallyGroupState state) {
    PageConstants.titleController.value =
        TextEditingValue(text: BlocProvider.of<TallyGroupCubit>(context).getSelectedGroup()?.title ?? "");
  }
}

class _DeleteButton extends StatelessWidget {
  final TallyGroupState state;
  const _DeleteButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (state.tallyGroups.isNotEmpty) ? () => _onDelete(context) : null,
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
    BlocProvider.of<TallyCounterCubit>(context)
        .removeGroupFromCounters(BlocProvider.of<TallyGroupCubit>(context).getSelectedGroup()!);
    Navigator.pop(context, "isDeleted");
    PageConstants.pageController.animateToPage(
      Pages.groupsOverviewPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
