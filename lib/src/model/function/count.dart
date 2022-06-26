import 'package:json_annotation/json_annotation.dart';

import '../range.dart';
import 'function.dart';

part 'count.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionCount extends LootFunction {
  final CountOrRange count;

  LootFunctionCount({
    required String function,
    required this.count,
  }) : super(function: function);

  factory LootFunctionCount.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionCountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionCountToJson(this);

  @override
  String toString() => 'Amount: $count';
}
