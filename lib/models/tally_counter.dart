
import 'package:json_annotation/json_annotation.dart';

part 'tally_counter.g.dart';

@JsonSerializable()
class TallyCounter {
  int count;

  TallyCounter({this.count = 0});

  factory TallyCounter.fromJson(Map<String, dynamic> json) => _$TallyCounterFromJson(json);

  Map<String, dynamic> toJson() => _$TallyCounterToJson(this);
}
