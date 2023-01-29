import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'parameter.dart';

part 'range.g.dart';

class CountOrRange {
  final num? count;
  final num? max;
  final num? min;

  const CountOrRange.count(this.count)
      : max = null,
        min = null;

  const CountOrRange.range(this.min, this.max) : count = null;

  factory CountOrRange.fromJson(dynamic cor) => cor is num
      ? CountOrRange.count(cor)
      : CountOrRange.range(cor['min'], cor['max']);

  dynamic toJson() => count ?? {'min': min, 'max': max};

  @override
  String toString() => count?.toString() ?? '$min-$max';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DoubleRange {
  final double max;
  final double min;

  DoubleRange({
    required this.max,
    required this.min,
  });

  factory DoubleRange.fromJson(Map<String, dynamic> json) =>
      _$DoubleRangeFromJson(json);

  Map<String, dynamic> toJson() => _$DoubleRangeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class IntegerRange {
  final int max;
  final int min;

  IntegerRange({
    required this.max,
    required this.min,
  });

  factory IntegerRange.fromJson(Map<String, dynamic> json) =>
      _$IntegerRangeFromJson(json);

  Map<String, dynamic> toJson() => _$IntegerRangeToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, genericArgumentFactories: true)
class SingleOrList<T> extends Named {
  final List<T> items;

  SingleOrList({
    required this.items,
  });

  @override
  get value => items;

  factory SingleOrList.fromJson(
          dynamic json, T Function(Object? json) fromJsonT) =>
      _$SingleOrListFromJson({
        'items': json is List ? json : [json],
      }, fromJsonT);

  dynamic toJson() =>
      items.length == 1 ? jsonDecode(jsonEncode(items.single)) : items;
}
