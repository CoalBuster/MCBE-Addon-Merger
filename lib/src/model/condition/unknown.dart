import 'package:json_annotation/json_annotation.dart';

import 'loot_condition.dart';

part 'unknown.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootConditionUnknown extends LootCondition {
  LootConditionUnknown({
    required String condition,
  }) : super(condition: condition);

  factory LootConditionUnknown.fromJson(Map<String, dynamic> json) =>
      _$LootConditionUnknownFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootConditionUnknownToJson(this);

  @override
  String toString() => '<$condition>';
}
