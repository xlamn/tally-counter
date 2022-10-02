import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'tally_counter_state.dart';

class TallyCounterCubit extends Cubit<TallyCounterState> {
  final TallyCounterRepository tallyCounterRepository;

  TallyCounterCubit({required this.tallyCounterRepository})
      : super(TallyCounterInitial([TallyCounter()], TallyCounter()));
  void loadTallyCounters() async {
    final tallyCounters = await tallyCounterRepository.getTallyCounters();
    final selected = await tallyCounterRepository.getLastSelected();
    emit(TallyCounterSuccess(tallyCounters, selected ?? tallyCounters.first));
  }

  // multiple counters

  void switchCounter(TallyCounter selected) {
    tallyCounterRepository.saveLastSelected(selected);
    emit(TallyCounterSuccess(state.tallyCounters, selected));
  }

  void addCounter() {
    emit(TallyCounterSuccess([...state.tallyCounters, TallyCounter()], state.selected));
  }

  void removeCounter(TallyCounter selected) {
    final tallyCounters = state.tallyCounters.toList();
    tallyCounters.remove(selected);
    emit(TallyCounterSuccess(tallyCounters, state.selected));
  }

  // counter itself

  void changeCounter({required TallyCounterAction action, required TallyCounter tallyCounter}) {
    switch (action) {
      case TallyCounterAction.increase:
        _increaseCounter(tallyCounter);
        break;
      case TallyCounterAction.decrease:
        _decreaseCounter(tallyCounter);
        break;
      case TallyCounterAction.reset:
        _resetCounter(tallyCounter);
        break;
    }
  }

  void _increaseCounter(TallyCounter tallyCounter) async {
    state.selected.count++;
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
    emit(TallyCounterSuccess(state.tallyCounters, state.selected));
  }

  void _decreaseCounter(TallyCounter tallyCounter) async {
    state.selected.count--;
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
    emit(TallyCounterSuccess(state.tallyCounters, state.selected));
  }

  void _resetCounter(TallyCounter tallyCounter) async {
    state.selected.count = 0;
    await tallyCounterRepository.saveTallyCounters(state.tallyCounters);
    emit(TallyCounterSuccess(state.tallyCounters, state.selected));
  }
}
