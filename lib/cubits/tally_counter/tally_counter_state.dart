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

class TallyCounterIncreaseSuccess extends TallyCounterSuccess {
  const TallyCounterIncreaseSuccess(super.tallyCounters);
}

class TallyCounterDecreaseSuccess extends TallyCounterSuccess {
  const TallyCounterDecreaseSuccess(super.tallyCounters);
}

class TallyCounterResetSuccess extends TallyCounterSuccess {
  const TallyCounterResetSuccess(super.tallyCounters);
}
