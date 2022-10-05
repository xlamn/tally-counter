import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'tally_counter_state.dart';

class TallyCounterCubit extends Cubit<TallyCounterState> {
  final TallyCounterRepository tallyCounterRepository;

  TallyCounterCubit({required this.tallyCounterRepository}) : super(TallyCounterState([TallyCounter()], 0));

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
        tallyCounters: [...state.tallyCounters, TallyCounter()],
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

  // counter itself

  void updateCount({required TallyCounterAction action}) async {
    switch (action) {
      case TallyCounterAction.increase:
        await updateCounter(count: _getSelectedCounter().count + 1);
        break;
      case TallyCounterAction.decrease:
        await updateCounter(count: _getSelectedCounter().count - 1);
        break;
      case TallyCounterAction.reset:
        await updateCounter(count: 0);
        break;
    }
  }

  Future<void> updateCounter({String? title, int? count}) async {
    emit(TallyCounterStateLoading(state.tallyCounters, state.selected));
    emit(state.copyCounter(title: title, count: count));
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
  }

  TallyCounter _getSelectedCounter() {
    return state.tallyCounters[state.selected];
  }
}
