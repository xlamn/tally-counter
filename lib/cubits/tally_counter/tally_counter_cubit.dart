import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../cubits.dart';

part 'tally_counter_state.dart';

class TallyCounterCubit extends Cubit<TallyCounterState> {
  final TallyCounterRepository tallyCounterRepository;
  final TallyGroupCubit tallyGroupCubit;

  TallyCounterCubit({required this.tallyCounterRepository, required this.tallyGroupCubit})
      : super(TallyCounterState([TallyCounter()], 0));

  List<TallyCounter> getTallyCountersFromSelectedGroup() {
    var filteredTallyCounters = state.tallyCounters;
    if (tallyGroupCubit.getSelectedGroup() != null) {
      filteredTallyCounters = filteredTallyCounters
          .where((tallyCounter) => tallyCounter.group?.title == tallyGroupCubit.getSelectedGroup()?.title)
          .toList();
    }
    return filteredTallyCounters;
  }

  // multiple counters

  void loadTallyCounters() async {
    final tallyCounters = await tallyCounterRepository.getTallyCounters();
    final position = await tallyCounterRepository.getLastTallyCounterPosition();
    emit(
      state.copyWith(
        tallyCounters: tallyCounters,
        selected: position,
      ),
    );
  }

  void switchCounter(TallyCounter selected) {
    final position = state.tallyCounters.indexOf(selected);
    tallyCounterRepository.saveLastTallyCounterPosition(position);
    emit(
      state.copyWith(
        tallyCounters: state.tallyCounters,
        selected: position,
      ),
    );
  }

  void addCounter() async {
    emit(
      state.copyWith(
        tallyCounters: [
          ...state.tallyCounters,
          TallyCounter(
            group: tallyGroupCubit.getSelectedGroup(),
          ),
        ],
        selected: state.selected,
      ),
    );
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
  }

  void removeCounter() async {
    final tallyCounters = state.tallyCounters.toList();
    tallyCounters.remove(_getSelectedCounter());
    emit(
      state.copyWith(
        tallyCounters: tallyCounters,
        selected: 0,
      ),
    );
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
  }

  void removeGroupFromCounters(TallyGroup tallyGroup) async {
    final tallyCounters = state.tallyCounters.toList();
    for (final tallyCounter in tallyCounters) {
      if (tallyCounter.group == tallyGroup) {
        tallyCounter.group = null;
      }
    }
    emit(
      state.copyWith(
        tallyCounters: tallyCounters,
        selected: state.selected,
      ),
    );
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
    tallyGroupCubit.removeGroup(tallyGroup: tallyGroup);
  }

  // counter itself

  void updateCount({required TallyCounterAction action}) async {
    switch (action) {
      case TallyCounterAction.increase:
        await updateCounter(count: _getSelectedCounter().count + _getSelectedCounter().step);
        break;
      case TallyCounterAction.decrease:
        await updateCounter(count: _getSelectedCounter().count - _getSelectedCounter().step);
        break;
      case TallyCounterAction.reset:
        await updateCounter(count: 0);
        break;
    }
  }

  Future<void> updateCounter({
    String? title,
    int? count,
    int? step,
    TallyGroup? group,
    bool forceOverrideGroup = false,
  }) async {
    emit(
      state.copyCounter(
        title: title,
        count: count,
        step: step,
        group: group,
        forceOverrideGroup: forceOverrideGroup,
      ),
    );
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
  }

  TallyCounter _getSelectedCounter() {
    return state.tallyCounters[state.selected];
  }
}
