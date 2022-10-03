import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/cubits/cubits.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class TallyCounterSettingsPage extends StatelessWidget {
  const TallyCounterSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TallyCounterCubit, TallyCounterState>(builder: (context, state) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: SizeConstants.large),
          child: Column(
            children: [
              const TitleHeader(
                title: 'Settings',
              ),
              FormTextField(
                tallyCounter: state.tallyCounters[state.selected],
                title: 'Title',
                textController: TextEditingController(text: state.tallyCounters[state.selected].title),
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
                  onPressed: () {
                    BlocProvider.of<TallyCounterCubit>(context).removeCounter();
                    Navigator.pop(context);
                    PageConstants.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear,
                    );
                  },
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
