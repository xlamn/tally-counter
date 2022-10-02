part of 'tally_counter_cubit.dart';

abstract class TallyCounterState {
  final List<TallyCounter> tallyCounters;
  final TallyCounter selected;

  const TallyCounterState(this.tallyCounters, this.selected);
}

class TallyCounterInitial extends TallyCounterState {
  TallyCounterInitial(super.tallyCounters, super.selected);
}

class TallyCounterSuccess extends TallyCounterState {
  const TallyCounterSuccess(super.tallyCounters, super.selected);
}
