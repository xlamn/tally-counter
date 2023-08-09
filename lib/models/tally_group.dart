import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../helper/color_converter.dart';

part 'tally_group.g.dart';

// ignore: must_be_immutable
@JsonSerializable()
class TallyGroup extends Equatable {
  final String title;

  @ColorConverter()
  Color? color;

  TallyGroup({required this.title, this.color});

  factory TallyGroup.fromJson(Map<String, dynamic> json) => _$TallyGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TallyGroupToJson(this);

  @override
  List<Object?> get props => [title, color];
}
