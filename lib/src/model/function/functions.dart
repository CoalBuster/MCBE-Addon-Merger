import 'package:json_annotation/json_annotation.dart';

import 'damage.dart';
import 'data.dart';
import 'enchant.dart';
import 'enchant_randomly.dart';
import 'exploration.dart';
import 'function.dart';
import 'count.dart';
import 'looting.dart';
import 'random_aux.dart';
import 'unknown.dart';

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
