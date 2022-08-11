// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleRange _$DoubleRangeFromJson(Map<String, dynamic> json) => DoubleRange(
      max: (json['max'] as num).toDouble(),
      min: (json['min'] as num).toDouble(),
    );

Map<String, dynamic> _$DoubleRangeToJson(DoubleRange instance) =>
    <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
    };

IntegerRange _$IntegerRangeFromJson(Map<String, dynamic> json) => IntegerRange(
      max: json['max'] as int,
      min: json['min'] as int,
    );

Map<String, dynamic> _$IntegerRangeToJson(IntegerRange instance) =>
    <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
    };

SingleOrList<T> _$SingleOrListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    SingleOrList<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$SingleOrListToJson<T>(
  SingleOrList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
    };
