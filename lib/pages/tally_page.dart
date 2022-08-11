import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../cubits/cubits.dart';
import '../enums/enums.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class TallyPage extends StatefulWidget {
  final TallyCounter tallyCounter;
  const TallyPage({
    Key? key,
    required this.tallyCounter,
  }) : super(key: key);

  @override
  State<TallyPage> createState() => _TallyPageState();
}

class _TallyPageState extends State<TallyPage> with TickerProviderStateMixin {
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _animateBackgroundColor(TallyCounterAction.increase);
          context.read<TallyCounterCubit>().changeCounter(
                tallyCounter: widget.tallyCounter,
                action: TallyCounterAction.increase,
              );
        },
        child: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  color: _animation?.value ?? _getStartColor(),
                  child: Center(
                    child: Text(
                      '${widget.tallyCounter.count}',
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
                      child: _BottomButtonRow(
                        tallyCounter: widget.tallyCounter,
                        backgroundColorAnimation: _animateBackgroundColor,
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
    return Colors.white;
  }

  Color _getEndColor(TallyCounterAction action) {
    switch (action) {
      case TallyCounterAction.increase:
        return Colors.greenAccent;

      case TallyCounterAction.decrease:
        return Colors.red;

      case TallyCounterAction.reset:
        return Colors.yellow;
    }
  }
}

class _BottomButtonRow extends StatelessWidget {
  final TallyCounter tallyCounter;
  final Function backgroundColorAnimation;
  const _BottomButtonRow({Key? key, required this.backgroundColorAnimation, required this.tallyCounter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TallyCounterButton(
          icon: const FaIcon(FontAwesomeIcons.arrowRotateLeft),
          onPressed: () {
            backgroundColorAnimation(TallyCounterAction.reset);
            context.read<TallyCounterCubit>().changeCounter(
                  tallyCounter: tallyCounter,
                  action: TallyCounterAction.reset,
                );
          },
        ),
        TallyCounterButton(
          icon: const FaIcon(FontAwesomeIcons.minus),
          onPressed: () {
            backgroundColorAnimation(TallyCounterAction.decrease);
            context.read<TallyCounterCubit>().changeCounter(
                  tallyCounter: tallyCounter,
                  action: TallyCounterAction.decrease,
                );
          },
        ),
      ],
    );
  }
}
