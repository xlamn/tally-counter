import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tally_counter.g.dart';

@JsonSerializable()
class TallyCounter extends Equatable {
  final int count;
  final String? title;

  const TallyCounter({this.count = 0, this.title});

  factory TallyCounter.fromJson(Map<String, dynamic> json) => _$TallyCounterFromJson(json);

  Map<String, dynamic> toJson() => _$TallyCounterToJson(this);

  @override
  List<Object?> get props => [count, title];
}
