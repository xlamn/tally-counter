import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tally_group.g.dart';

@JsonSerializable()
class TallyGroup extends Equatable {
  final String? title;

  const TallyGroup({this.title});

  factory TallyGroup.fromJson(Map<String, dynamic> json) => _$TallyGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TallyGroupToJson(this);

  @override
  List<Object?> get props => [title];
}
