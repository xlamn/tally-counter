part of 'tally_group_cubit.dart';

class TallyGroupState {
  final List<TallyGroup> tallyGroups;
  final int? selected;

  const TallyGroupState(this.tallyGroups, {this.selected});

  TallyGroupState copyWith({
    List<TallyGroup>? tallyGroups,
    int? selected,
  }) {
    return TallyGroupState(
      tallyGroups ?? this.tallyGroups,
      selected: selected,
    );
  }

  TallyGroupState copyGroup({
    String? title,
    Color? color,
  }) {
    if (selected != null) {
      final tallyGroup = tallyGroups[selected!];
      tallyGroups[selected!] = TallyGroup(
        title: title ?? tallyGroup.title,
        color: color ?? tallyGroup.color,
      );
    }
    return TallyGroupState(tallyGroups, selected: selected);
  }
}
