import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/models/tally_counter.dart';
import 'package:tally_counter/repositories/tally_counter_repository.dart';

part 'tally_counter_state.dart';

class TallyCounterCubit extends Cubit<TallyCounterState> {
  final TallyCounterRepository tallyCounterRepository;

  TallyCounterCubit({required this.tallyCounterRepository}) : super(TallyCounterInitial([TallyCounter()]));
  void loadTallyCounters() async {
    final tallyCounters = await tallyCounterRepository.getTallyCounters();
    emit(TallyCounterSuccess(tallyCounters));
  }

  void increaseCounter(TallyCounter tallyCounter) async {
    tallyCounter.count++;
    await tallyCounterRepository.saveTallyCounters([tallyCounter]);
    emit(TallyCounterIncreaseTransition([tallyCounter]));
    await Future.delayed(const Duration(seconds: 2));
    emit(TallyCounterSuccess([tallyCounter]));
  }

  void decreaseCounter(TallyCounter tallyCounter) async {
    tallyCounter.count--;
    await tallyCounterRepository.saveTallyCounters([tallyCounter]);
    emit(TallyCounterDecreaseTransition([tallyCounter]));
    await Future.delayed(const Duration(seconds: 2));
    emit(TallyCounterSuccess([tallyCounter]));
  }

  void resetCounter(TallyCounter tallyCounter) async {
    tallyCounter.count = 0;
    await tallyCounterRepository.saveTallyCounters([tallyCounter]);
    emit(TallyCounterResetSuccess([tallyCounter]));
    await Future.delayed(const Duration(seconds: 2));
    emit(TallyCounterSuccess([tallyCounter]));
  }
}
