part of 'tally_counter_cubit.dart';

class TallyCounterState {
  final List<TallyCounter> tallyCounters;
  final int selected;

  const TallyCounterState(this.tallyCounters, this.selected);

  TallyCounterState copyWith({List<TallyCounter>? tallyCounters, int? selected}) {
    return TallyCounterState(
      tallyCounters ?? this.tallyCounters,
      selected ?? this.selected,
    );
  }

  TallyCounterState copyCounter({String? title, int? count, int? step}) {
    final tallyCounter = tallyCounters[selected];

    tallyCounters[selected] = TallyCounter(
      title: title ?? tallyCounter.title,
      count: count ?? tallyCounter.count,
      step: step ?? tallyCounter.step,
    );
    return TallyCounterState(tallyCounters, selected);
  }
}
