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
