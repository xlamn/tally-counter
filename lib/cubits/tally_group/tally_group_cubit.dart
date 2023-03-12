import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'tally_group_state.dart';

class TallyGroupCubit extends Cubit<TallyGroupState> {
  final TallyCounterRepository tallyCounterRepository;

  TallyGroupCubit({required this.tallyCounterRepository}) : super(const TallyGroupState([]));

  void loadTallyGroups() async {
    final tallyGroups = await tallyCounterRepository.getTallyGroups();
    emit(
      state.copyWith(
        tallyGroups: tallyGroups,
      ),
    );
  }

  void switchGroup({TallyGroup? selected}) {
    int? position;
    if (selected != null) position = state.tallyGroups.indexOf(selected);
    emit(
      state.copyWith(
        tallyGroups: state.tallyGroups,
        selected: position,
      ),
    );
  }

  void addGroup() async {
    emit(
      state.copyWith(
        tallyGroups: [...state.tallyGroups, const TallyGroup()],
        selected: state.selected,
      ),
    );
    await tallyCounterRepository.saveTallyGroups(state.tallyGroups);
  }

  void removeGroup() async {
    final tallyGroups = state.tallyGroups.toList();
    tallyGroups.remove(getSelectedGroup());
    emit(
      state.copyWith(
        tallyGroups: tallyGroups,
        selected: 0,
      ),
    );
    await tallyCounterRepository.saveTallyGroups(state.tallyGroups);
  }

  TallyGroup? getSelectedGroup() {
    if (state.selected != null) {
      return state.tallyGroups[state.selected!];
    } else {
      return null;
    }
  }
}
