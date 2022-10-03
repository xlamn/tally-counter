part of 'tally_counter_cubit.dart';

class TallyCounterState {
  final List<TallyCounter> tallyCounters;
  final int selected;

  const TallyCounterState(this.tallyCounters, this.selected);

  TallyCounterState copyWith({String? title, int? count}) {
    final tallyCounter = tallyCounters[selected];
    tallyCounters[selected] = TallyCounter(
      title: title ?? tallyCounter.title,
      count: count ?? tallyCounter.count,
    );
    return TallyCounterState(tallyCounters, selected);
  }
}

class TallyCounterInitial extends TallyCounterState {
  TallyCounterInitial(super.tallyCounters, super.selected);
}

class TallyCounterSuccess extends TallyCounterState {
  const TallyCounterSuccess(super.tallyCounters, super.selected);
}
