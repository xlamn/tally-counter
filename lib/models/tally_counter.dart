import 'package:json_annotation/json_annotation.dart';

import 'tally_group.dart';

part 'tally_counter.g.dart';

@JsonSerializable()
class TallyCounter {
  final int count;
  final String? title;
  final int step;
  TallyGroup? group;

  TallyCounter({this.count = 0, this.title, this.step = 1, this.group});

  factory TallyCounter.fromJson(Map<String, dynamic> json) => _$TallyCounterFromJson(json);

  Map<String, dynamic> toJson() => _$TallyCounterToJson(this);
}
