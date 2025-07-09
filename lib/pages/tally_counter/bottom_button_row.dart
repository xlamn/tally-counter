import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'reset_sheet.dart';

class BottomButtonRow extends StatelessWidget {
  final TallyCounter tallyCounter;
  final Function backgroundColorAnimation;

  const BottomButtonRow({
    super.key,
    required this.backgroundColorAnimation,
    required this.tallyCounter,
  });

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
                onPressed: () => showResetActionSheet(
                  context,
                  backgroundColorAnimation: backgroundColorAnimation,
                ),
              ),
              TallyCounterButton(
                icon: const FaIcon(FontAwesomeIcons.minus),
                onPressed: () {
                  context.read<TallyCounterCubit>().updateCount(
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
}
