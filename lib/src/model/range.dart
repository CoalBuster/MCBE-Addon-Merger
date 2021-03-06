import 'package:json_annotation/json_annotation.dart';

part 'range.g.dart';

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
