import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/cubits/cubits.dart';

import '../../constants/constants.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class TallyCounterSettingsPage extends StatelessWidget {
  final TallyCounter tallyCounter;

  const TallyCounterSettingsPage({Key? key, required this.tallyCounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const TitleHeader(
            title: 'Settings',
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
                BlocProvider.of<TallyCounterCubit>(context).removeCounter(tallyCounter);
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
    );
  }
}
