import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/models/tally_counter.dart';
import 'package:tally_counter/repositories/tally_counter_repository.dart';

import '../../enums/enums.dart';

part 'tally_counter_state.dart';

class TallyCounterCubit extends Cubit<TallyCounterState> {
  final TallyCounterRepository tallyCounterRepository;

  TallyCounterCubit({required this.tallyCounterRepository}) : super(TallyCounterInitial([TallyCounter()]));
  void loadTallyCounters() async {
    final tallyCounters = await tallyCounterRepository.getTallyCounters();
    emit(TallyCounterSuccess(tallyCounters));
  }

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
    tallyCounter.count++;
    await tallyCounterRepository.saveTallyCounters([tallyCounter]);
    emit(TallyCounterSuccess([tallyCounter]));
  }

  void _decreaseCounter(TallyCounter tallyCounter) async {
    tallyCounter.count--;
    await tallyCounterRepository.saveTallyCounters([tallyCounter]);
    emit(TallyCounterSuccess([tallyCounter]));
  }

  void _resetCounter(TallyCounter tallyCounter) async {
    tallyCounter.count = 0;
    await tallyCounterRepository.saveTallyCounters([tallyCounter]);
    emit(TallyCounterSuccess([tallyCounter]));
  }
}
