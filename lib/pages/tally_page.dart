import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubits/cubits.dart';
import '../models/models.dart';

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
                      padding: const EdgeInsets.all(
                        SizeConstants.small,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(
                              SizeConstants.small,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            height: 44,
                            width: 44,
                            child: IconButton(
                              icon: const Icon(Icons.circle),
                              color: Colors.white,
                              onPressed: () {
                                context.read<TallyCounterCubit>().resetCounter(tallyCounter);
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(
                              SizeConstants.small,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            height: 44,
                            width: 44,
                            child: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              color: Colors.white,
                              onPressed: () {
                                context.read<TallyCounterCubit>().decreaseCounter(tallyCounter);
                              },
                            ),
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
