import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    super.key,
    required this.tallyCounter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: SlideAction(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeConstants.normalSmaller,
            vertical: SizeConstants.xLarge + SizeConstants.xxSmall,
          ),
          color: Colors.red,
          icon: FaIcon(
            FontAwesomeIcons.trash,
            size: SizeConstants.normal,
            color: context.isDarkMode ? Colors.redAccent : Colors.red.withValues(alpha: 0.8),
          ),
          onTap: (context) => _onDelete(context),
          child: _CounterContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StepButton(
                  color: Colors.red,
                  icon: FaIcon(
                    FontAwesomeIcons.arrowDown,
                    color: context.isDarkMode ? Colors.redAccent : Colors.red.withValues(alpha: 0.8),
                  ),
                  onPressed: () => _onPressed(context, isUp: false),
                ),
                _CounterInfo(
                  tallyCounter: tallyCounter,
                ),
                StepButton(
                  color: Colors.green,
                  icon: FaIcon(
                    FontAwesomeIcons.arrowUp,
                    color: context.isDarkMode ? Colors.greenAccent : Colors.green,
                  ),
                  onPressed: () => _onPressed(context, isUp: true),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => _onTallyCounterTap(context),
    );
  }

  void _onTallyCounterTap(BuildContext context) {
    BlocProvider.of<TallyCounterCubit>(context).switchCounter(tallyCounter);
    PageConstants.pageController.animateToPage(
      Pages.tallyCounterPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }

  void _onPressed(BuildContext context, {required bool isUp}) {
    final cubit = BlocProvider.of<TallyCounterCubit>(context);
    cubit.switchCounter(tallyCounter);
    cubit.updateCount(action: isUp ? TallyCounterAction.increase : TallyCounterAction.decrease);
  }

  void _onDelete(BuildContext context) {
    Slidable.of(context)?.dismiss(
      ResizeRequest(
        const Duration(milliseconds: 250),
        () => BlocProvider.of<TallyCounterCubit>(context).removeCounter(tallyCounter: tallyCounter),
      ),
    );
  }
}

class _CounterContainer extends StatelessWidget {
  final Widget child;

  const _CounterContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SizeConstants.small),
      padding: const EdgeInsets.all(SizeConstants.large),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey[600] : Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(
              0,
              SizeConstants.small,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(
          RadiusConstants.large,
        ),
      ),
      child: child,
    );
  }
}

class _CounterInfo extends StatelessWidget {

  final TallyCounter tallyCounter;

  const _CounterInfo({required this.tallyCounter});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: SizeConstants.xxSmall,
              horizontal: SizeConstants.small,
            ),
            child: Text(
              tallyCounter.title.isNotEmpty ? tallyCounter.title : context.local.noName,
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
    );
  }
}
