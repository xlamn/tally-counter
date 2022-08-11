import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/models/tally_counter.dart';

part 'tally_counter_state.dart';

class TallyCounterCubit extends Cubit<TallyCounterState> {
  TallyCounterCubit() : super(const TallyCounterInitial([]));

  void increaseCounter(TallyCounter tallyCounter) {
    tallyCounter.count++;
    emit(TallyCounterIncreaseSuccess([tallyCounter]));
  }

  void decreaseCounter(TallyCounter tallyCounter) {
    tallyCounter.count--;
    emit(TallyCounterDecreaseSuccess([tallyCounter]));
  }

  void resetCounter(TallyCounter tallyCounter) {
    tallyCounter.count = 0;
    emit(TallyCounterResetSuccess([tallyCounter]));
  }
}
