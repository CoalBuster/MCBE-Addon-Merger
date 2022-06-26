import 'package:json_annotation/json_annotation.dart';

import '../range.dart';
import 'function.dart';

part 'enchant_randomly.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionEnchantRandomly extends LootFunction {
  final double? chance;
  final CountOrRange? levels;
  final bool treasure;

  LootFunctionEnchantRandomly({
    required String function,
    this.chance,
    this.levels,
    this.treasure = false,
  }) : super(function: function);

  factory LootFunctionEnchantRandomly.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionEnchantRandomlyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionEnchantRandomlyToJson(this);

  @override
  String toString() =>
      (treasure ? 'Treasure Enchantment' : 'Randomly Enchanted') +
      (levels == null ? '' : ' (lvl: $levels)') +
      (chance == null ? '' : ' (${chance! * 100}% chance)');
}
