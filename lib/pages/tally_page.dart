import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../cubits/cubits.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class TallyPage extends StatelessWidget {
  final TallyCounter tallyCounter;
  const TallyPage({
    Key? key,
    required this.tallyCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.read<TallyCounterCubit>().increaseCounter(tallyCounter);
        },
        child: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  color: _getBackgroundColor(state),
                  child: Center(
                    child: Text(
                      '${tallyCounter.count}',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                SafeArea(
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
                            onPressed: () {
                              context.read<TallyCounterCubit>().resetCounter(tallyCounter);
                            },
                          ),
                          TallyCounterButton(
                            icon: const FaIcon(FontAwesomeIcons.anglesDown),
                            onPressed: () {
                              context.read<TallyCounterCubit>().decreaseCounter(tallyCounter);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color? _getBackgroundColor(TallyCounterState state) {
    if (state is TallyCounterIncreaseTransition) {
      return Colors.lightGreen;
    }
    if (state is TallyCounterDecreaseTransition) {
      return Colors.red;
    }
    return null;
  }
}
