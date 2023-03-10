import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import 'bottom_button_row.dart';
import 'top_button_row.dart';

class TallyCounterPage extends StatefulWidget {
  const TallyCounterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TallyCounterPage> createState() => _TallyCounterPageState();
}

class _TallyCounterPageState extends State<TallyCounterPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  Animation<Color?>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 100),
      reverseDuration: const Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TallyCounterCubit, TallyCounterState>(
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.read<TallyCounterCubit>().updateCount(
                    action: TallyCounterAction.increase,
                  );
              _animateBackgroundColor(TallyCounterAction.increase);
              HapticFeedback.lightImpact();
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.3,
                  ),
                  color: _animation?.value ?? _getStartColor(),
                  child: Center(
                    child: Text(
                      '${state.tallyCounters[state.selected].count}',
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                TopButtonRow(
                  tallyCounter: state.tallyCounters[state.selected],
                ),
                BottomButtonRow(
                  tallyCounter: state.tallyCounters[state.selected],
                  backgroundColorAnimation: _animateBackgroundColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _animateBackgroundColor(TallyCounterAction action) {
    _animation = ColorTween(
      begin: _getStartColor(),
      end: _getEndColor(action),
    ).animate(_controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    _controller.forward();
  }

  Color _getStartColor() {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  Color _getEndColor(TallyCounterAction action) {
    switch (action) {
      case TallyCounterAction.increase:
        return Colors.green;

      case TallyCounterAction.decrease:
        return Colors.red.withOpacity(0.8);

      case TallyCounterAction.reset:
        return Colors.yellow;
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
