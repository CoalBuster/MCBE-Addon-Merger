import 'package:json_annotation/json_annotation.dart';

import 'loot_condition.dart';

part 'player_kill.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootConditionPlayerKill extends LootCondition {
  LootConditionPlayerKill({
    required String condition,
  }) : super(condition: condition);

  factory LootConditionPlayerKill.fromJson(Map<String, dynamic> json) =>
      _$LootConditionPlayerKillFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootConditionPlayerKillToJson(this);

  @override
  String toString() => 'Player Kill Required';
}
