
import 'package:json_annotation/json_annotation.dart';

import 'enchantment.dart';
import 'range.dart';

part 'function.g.dart';

abstract class LootFunction {
  final String function;

  LootFunction({
    required this.function,
  });

  Map<String, dynamic> toJson();
}

class LootFunctions
    implements JsonConverter<LootFunction, Map<String, dynamic>> {
  static const _functions = {
    'set_count': LootFunctionCount.fromJson,
    'minecraft:set_count': LootFunctionCount.fromJson,
    'set_damage': LootFunctionDamage.fromJson,
    'minecraft:set_damage': LootFunctionDamage.fromJson,
    'set_data': LootFunctionData.fromJson,
    'minecraft:set_data': LootFunctionData.fromJson,
    'specific_enchants': LootFunctionEnchant.fromJson,
    'enchant_randomly': LootFunctionEnchantRandomly.fromJson,
    'minecraft:enchant_randomly': LootFunctionEnchantRandomly.fromJson,
    'enchant_random_gear': LootFunctionEnchantRandomly.fromJson,
    'enchant_with_levels': LootFunctionEnchantRandomly.fromJson,
    'exploration_map': LootFunctionExploration.fromJson,
    'looting_enchant': LootFunctionLooting.fromJson,
    'random_aux_value': LootFunctionRandomAux.fromJson,
  };

  const LootFunctions();

  @override
  LootFunction fromJson(Map<String, dynamic> json) {
    final function = json['function'];
    return _functions[function]?.call(json) ??
        LootFunctionUnknown(
          function: function,
        );
  }

  @override
  Map<String, dynamic> toJson(LootFunction function) => function.toJson();
}

///
/// Loot Functions
///

/// Loot Amount
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

/// Loot Damage
@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionDamage extends LootFunction {
  final DoubleRange damage;

  LootFunctionDamage({
    required super.function,
    required this.damage,
  });

  factory LootFunctionDamage.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionDamageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionDamageToJson(this);

  @override
  String toString() => 'Damaged (${damage.min * 100}% - ${damage.max * 100}%)';
}

/// Loot Data
@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionData extends LootFunction {
  final CountOrRange data;

  LootFunctionData({
    required String function,
    required this.data,
  }) : super(function: function);

  factory LootFunctionData.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionDataToJson(this);

  @override
  String toString() => 'Data: $data';
}

/// Randomly Enchanted Loot
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

/// Specifically Enchanted Loot
@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionEnchant extends LootFunction {
  final List<Enchantment> enchants;

  LootFunctionEnchant({
    required String function,
    required this.enchants,
  }) : super(function: function);

  factory LootFunctionEnchant.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionEnchantFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionEnchantToJson(this);

  @override
  String toString() =>
      'Enchanted with: ${enchants.map((e) => e.toString()).join(', ')}';
}

/// Exploration Map
@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionExploration extends LootFunction {
  final String destination;

  LootFunctionExploration({
    required String function,
    required this.destination,
  }) : super(function: function);

  factory LootFunctionExploration.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionExplorationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionExplorationToJson(this);

  @override
  String toString() => 'Exploration to: $destination';
}

/// Looting Affected Loot
@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionLooting extends LootFunction {
  final IntegerRange count;

  LootFunctionLooting({
    required String function,
    required this.count,
  }) : super(function: function);

  factory LootFunctionLooting.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionLootingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionLootingToJson(this);

  @override
  String toString() => 'Looting: +${count.min}-${count.max} per lvl';
}

/// Loot Aux
@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionRandomAux extends LootFunction {
  final IntegerRange values;

  LootFunctionRandomAux({
    required String function,
    required this.values,
  }) : super(function: function);

  factory LootFunctionRandomAux.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionRandomAuxFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionRandomAuxToJson(this);

  @override
  String toString() => 'Random aux: ${values.min} - ${values.max}';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionUnknown extends LootFunction {
  LootFunctionUnknown({required String function}) : super(function: function);

  factory LootFunctionUnknown.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionUnknownFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionUnknownToJson(this);

  @override
  String toString() => '<$function>';
}
