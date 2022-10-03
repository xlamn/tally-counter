import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class BottomButtonRow extends StatelessWidget {
  final TallyCounter tallyCounter;
  final Function backgroundColorAnimation;
  const BottomButtonRow({
    Key? key,
    required this.backgroundColorAnimation,
    required this.tallyCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: SizeConstants.small,
            horizontal: SizeConstants.normal,
          ),
          child: Row(
            children: [
              TallyCounterButton(
                icon: const FaIcon(FontAwesomeIcons.arrowRotateLeft),
                onPressed: () => _showResetDialog(context),
              ),
              TallyCounterButton(
                icon: const FaIcon(FontAwesomeIcons.minus),
                onPressed: () {
                  context.read<TallyCounterCubit>().changeCounter(
                        tallyCounter: tallyCounter,
                        action: TallyCounterAction.decrease,
                      );
                  backgroundColorAnimation(TallyCounterAction.decrease);
                  HapticFeedback.lightImpact();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showResetDialog(BuildContext context) {
    showAlertDialog(
      context,
      title: 'Warning',
      description: 'Are you sure to reset the Counter?',
      cancelText: 'Cancel',
      actionText: 'Reset',
      action: () {
        context.read<TallyCounterCubit>().changeCounter(
              tallyCounter: tallyCounter,
              action: TallyCounterAction.reset,
            );
        backgroundColorAnimation(TallyCounterAction.reset);
        HapticFeedback.mediumImpact();
      },
    );
  }
}