import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/constants/constants.dart';

import '../../cubits/cubits.dart';
import '../../models/models.dart';

class TallyCounterItem extends StatelessWidget {
  final TallyCounter tallyCounter;

  const TallyCounterItem({
    Key? key,
    required this.tallyCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(SizeConstants.large),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(SizeConstants.xxSmall),
              child: Text(
                tallyCounter.title?.isNotEmpty ?? false ? tallyCounter.title! : 'No Name',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(SizeConstants.xxSmall),
              child: Text(
                '${tallyCounter.count}',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
      onTap: () => _onTallyCounterTap(context),
    );
  }

  void _onTallyCounterTap(BuildContext context) {
    BlocProvider.of<TallyCounterCubit>(context).switchCounter(tallyCounter);
    PageConstants.pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
