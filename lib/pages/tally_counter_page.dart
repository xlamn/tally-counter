import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../cubits/cubits.dart';
import '../enums/enums.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class TallyCounterPage extends StatefulWidget {
  final TallyCounter tallyCounter;
  const TallyCounterPage({
    Key? key,
    required this.tallyCounter,
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.read<TallyCounterCubit>().changeCounter(
                tallyCounter: widget.tallyCounter,
                action: TallyCounterAction.increase,
              );
          _animateBackgroundColor(TallyCounterAction.increase);
          HapticFeedback.lightImpact();
        },
        child: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.3,
                  ),
                  color: _animation?.value ?? _getStartColor(),
                  child: Center(
                    child: Text(
                      '${widget.tallyCounter.count}',
                      style: const TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                // _TopButtonRow(
                //   tallyCounter: widget.tallyCounter,
                // ),
                _BottomButtonRow(
                  tallyCounter: widget.tallyCounter,
                  backgroundColorAnimation: _animateBackgroundColor,
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
        return Colors.red.withOpacity(0.8);

      case TallyCounterAction.reset:
        return Colors.yellow;
    }
  }
}

class _TopButtonRow extends StatelessWidget {
  final TallyCounter tallyCounter;

  const _TopButtonRow({Key? key, required this.tallyCounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: SizeConstants.small,
            horizontal: SizeConstants.normal,
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                margin: const EdgeInsets.all(
                  SizeConstants.small,
                ),
                child: IconButton(
                    iconSize: SizeConstants.large,
                    icon: const Icon(Icons.info_outline, size: 32),
                    color: Colors.black.withOpacity(0.4),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomButtonRow extends StatelessWidget {
  final TallyCounter tallyCounter;
  final Function backgroundColorAnimation;
  const _BottomButtonRow({
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
