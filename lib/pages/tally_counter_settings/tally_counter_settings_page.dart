import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/cubits/cubits.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class TallyCounterSettingsPage extends StatelessWidget {
  const TallyCounterSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TallyCounterCubit, TallyCounterState>(
      builder: (context, state) {
        PageConstants.titleController.value = TextEditingValue(
          text: state.tallyCounters[state.selected].title ?? '',
        );
        PageConstants.countController.value = TextEditingValue(
          text: '${state.tallyCounters[state.selected].count}',
        );

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: SizeConstants.large),
            child: Column(
              children: [
                const SizedBox(
                  height: SizeConstants.large,
                ),
                FormTextField(
                  tallyCounter: state.tallyCounters[state.selected],
                  title: 'Title',
                  textController: PageConstants.titleController,
                ),
                FormValueField(
                  tallyCounter: state.tallyCounters[state.selected],
                  title: 'Value',
                  valueController: PageConstants.countController,
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  margin: const EdgeInsets.all(SizeConstants.normal),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.all(SizeConstants.normalSmaller),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: (state.tallyCounters.length > 1) ? () => _onDelete(context) : null,
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDelete(BuildContext context) {
    BlocProvider.of<TallyCounterCubit>(context).removeCounter();
    Navigator.pop(context);
    PageConstants.pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
