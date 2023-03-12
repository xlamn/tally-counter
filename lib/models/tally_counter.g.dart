// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tally_counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TallyCounter _$TallyCounterFromJson(Map<String, dynamic> json) => TallyCounter(
      count: json['count'] as int? ?? 0,
      title: json['title'] as String?,
      step: json['step'] as int? ?? 1,
      group: json['group'] == null
          ? null
          : TallyGroup.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TallyCounterToJson(TallyCounter instance) =>
    <String, dynamic>{
      'count': instance.count,
      'title': instance.title,
      'step': instance.step,
      'group': instance.group,
    };
