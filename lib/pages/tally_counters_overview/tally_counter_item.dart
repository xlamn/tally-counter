import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import '../../extensions/extensions.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

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
        margin: const EdgeInsets.all(SizeConstants.small),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(SizeConstants.large),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StepButton(
              color: Colors.red,
              icon: FaIcon(
                FontAwesomeIcons.arrowDown,
                color: Colors.red.withOpacity(0.8),
              ),
              onPressed: () => _onPressed(context, isUp: false),
            ),
            Flexible(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: SizeConstants.xxSmall,
                      horizontal: SizeConstants.small,
                    ),
                    child: Text(
                      tallyCounter.title?.isNotEmpty ?? false ? tallyCounter.title! : context.local.noName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.headlineMedium!.color,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      SizeConstants.xxSmall,
                    ),
                    child: Text(
                      '${tallyCounter.count}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StepButton(
              color: Colors.green,
              icon: const FaIcon(
                FontAwesomeIcons.arrowUp,
                color: Colors.green,
              ),
              onPressed: () => _onPressed(context, isUp: true),
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

  void _onPressed(BuildContext context, {required bool isUp}) {
    final cubit = BlocProvider.of<TallyCounterCubit>(context);
    cubit.switchCounter(tallyCounter);
    cubit.updateCount(action: isUp ? TallyCounterAction.increase : TallyCounterAction.decrease);
  }
}
