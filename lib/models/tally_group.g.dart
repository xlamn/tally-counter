// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tally_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TallyGroup _$TallyGroupFromJson(Map<String, dynamic> json) => TallyGroup(
      title: json['title'] as String,
      color: _$JsonConverterFromJson<String, Color>(
          json['color'], const ColorConverter().fromJson),
    );

Map<String, dynamic> _$TallyGroupToJson(TallyGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'color': _$JsonConverterToJson<String, Color>(
          instance.color, const ColorConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
