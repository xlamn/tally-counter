part of 'tally_counter_cubit.dart';

abstract class TallyCounterState {
  final List<TallyCounter> tallyCounters;

  const TallyCounterState(this.tallyCounters);
}

class TallyCounterInitial extends TallyCounterState {
  const TallyCounterInitial(super.tallyCounters);
}

class TallyCounterSuccess extends TallyCounterState {
  const TallyCounterSuccess(super.tallyCounters);
}

class TallyCounterIncreaseTransition extends TallyCounterState {
  const TallyCounterIncreaseTransition(super.tallyCounters);
}

class TallyCounterDecreaseTransition extends TallyCounterState {
  const TallyCounterDecreaseTransition(super.tallyCounters);
}

class TallyCounterResetSuccess extends TallyCounterSuccess {
  const TallyCounterResetSuccess(super.tallyCounters);
}
