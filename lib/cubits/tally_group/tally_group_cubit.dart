import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'tally_group_state.dart';

class TallyGroupCubit extends Cubit<TallyGroupState> {
  final TallyCounterRepository tallyCounterRepository;

  TallyGroupCubit({required this.tallyCounterRepository}) : super(const TallyGroupState([]));

  // multiple groups

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

  void addGroup({required String title}) async {
    emit(
      state.copyWith(
        tallyGroups: [
          ...state.tallyGroups,
          TallyGroup(
            title: title,
          )
        ],
        selected: state.selected,
      ),
    );
    await tallyCounterRepository.saveTallyGroups(state.tallyGroups);
  }

  void removeGroup({required TallyGroup tallyGroup}) async {
    final tallyGroups = state.tallyGroups.toList();
    tallyGroups.remove(tallyGroup);
    emit(
      state.copyWith(
        tallyGroups: tallyGroups,
        selected: null,
      ),
    );
    await tallyCounterRepository.saveTallyGroups(state.tallyGroups);
  }

  // group itself

  Future<void> updateGroup({
    String? title,
    Color? color,
  }) async {
    emit(
      state.copyGroup(
        title: title,
        color: color,
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
