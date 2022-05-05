import 'package:json_annotation/json_annotation.dart';
import 'package:mcbe_addon_merger/src/model/range.dart';
import 'package:numerus/numerus.dart';

import '../count_or_range.dart';

part 'functions.g.dart';

class MinecraftFunction {
  final String function;

  MinecraftFunction({
    required this.function,
  });

  factory MinecraftFunction.fromJson(Map<String, dynamic> json) {
    final function = json['function'] as String;
    switch (function) {
      case 'set_count':
      case 'minecraft:set_count':
        return MinecraftFunctionCount.fromJson(json);
      case 'set_damage':
      case 'minecraft:set_damage':
        return MinecraftFunctionDamage.fromJson(json);
      case 'set_data':
      case 'minecraft:set_data':
        return MinecraftFunctionData.fromJson(json);
      case 'specific_enchants':
        return MinecraftFunctionEnchant.fromJson(json);
      case 'enchant_randomly':
      case 'minecraft:enchant_randomly':
      case 'enchant_with_levels':
        return MinecraftFunctionEnchantRandomly.fromJson(json);
      case 'exploration_map':
        return MinecraftFunctionExploration.fromJson(json);
      case 'random_aux_value':
        return MinecraftFunctionRandomAux.fromJson(json);
      default:
        return MinecraftFunctionUnknown(
          function: function,
        );
    }
  }

  Map<String, dynamic> toJson() => {
        'function': function,
      };
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionCount extends MinecraftFunction {
  final CountOrRange count;

  MinecraftFunctionCount({
    required String function,
    required this.count,
  }) : super(function: function);

  factory MinecraftFunctionCount.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionCountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionCountToJson(this);

  @override
  String toString() => 'Amount: $count';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionDamage extends MinecraftFunction {
  final DoubleRange damage;

  MinecraftFunctionDamage({
    required String function,
    required this.damage,
  }) : super(function: function);

  factory MinecraftFunctionDamage.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionDamageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionDamageToJson(this);

  @override
  String toString() => 'Damaged (${damage.min * 100}% - ${damage.max * 100}%)';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionData extends MinecraftFunction {
  final int data;

  MinecraftFunctionData({
    required String function,
    required this.data,
  }) : super(function: function);

  factory MinecraftFunctionData.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionDataToJson(this);

  @override
  String toString() => 'Data: $data';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionEnchant extends MinecraftFunction {
  final List<MinecraftEnchantment> enchants;

  MinecraftFunctionEnchant({
    required String function,
    required this.enchants,
  }) : super(function: function);

  factory MinecraftFunctionEnchant.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionEnchantFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionEnchantToJson(this);

  @override
  String toString() =>
      'Enchanted with: ${enchants.map((e) => e.toString()).join(', ')}';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionEnchantRandomly extends MinecraftFunction {
  final IntegerRange? levels;
  final bool treasure;

  MinecraftFunctionEnchantRandomly({
    required String function,
    this.levels,
    this.treasure = false,
  }) : super(function: function);

  factory MinecraftFunctionEnchantRandomly.fromJson(
          Map<String, dynamic> json) =>
      _$MinecraftFunctionEnchantRandomlyFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$MinecraftFunctionEnchantRandomlyToJson(this);

  @override
  String toString() =>
      (treasure ? 'Treasure Enchantment' : 'Randomly Enchanted') +
      (levels == null ? '' : ' (lvl: ${levels!.min} - ${levels!.max})');
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionExploration extends MinecraftFunction {
  final String destination;

  MinecraftFunctionExploration({
    required String function,
    required this.destination,
  }) : super(function: function);

  factory MinecraftFunctionExploration.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionExplorationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionExplorationToJson(this);

  @override
  String toString() => 'Exploration to: $destination';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionRandomAux extends MinecraftFunction {
  final IntegerRange values;

  MinecraftFunctionRandomAux({
    required String function,
    required this.values,
  }) : super(function: function);

  factory MinecraftFunctionRandomAux.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionRandomAuxFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionRandomAuxToJson(this);

  @override
  String toString() => 'Random aux: ${values.min} - ${values.max}';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftFunctionUnknown extends MinecraftFunction {
  MinecraftFunctionUnknown({required String function})
      : super(function: function);

  factory MinecraftFunctionUnknown.fromJson(Map<String, dynamic> json) =>
      _$MinecraftFunctionUnknownFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftFunctionUnknownToJson(this);

  @override
  String toString() => '<unknown function>';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftEnchantment {
  final String id;
  final List<int> level;

  MinecraftEnchantment({
    required this.id,
    required this.level,
  });

  factory MinecraftEnchantment.fromJson(Map<String, dynamic> json) =>
      _$MinecraftEnchantmentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftEnchantmentToJson(this);

  @override
  String toString() =>
      '$id (${level.map((e) => e.toRomanNumeralString()).join(' - ')})';
}

// @JsonSerializable(fieldRename: FieldRename.snake)
// class MinecraftLootFunction {
//   final CountOrRange? count;
//   final DoubleRange? damage;
//   final int? data;
//   final String? destination;
//   final MinecraftLootFuntionType function;
//   final CountOrRange? levels;
//   final bool? treasure;
//   final IntegerRange? values;

//   MinecraftLootFunction({
//     required this.function,
//     this.count,
//     this.damage,
//     this.destination,
//     this.data,
//     this.levels,
//     this.treasure,
//     this.values,
//   });

//   factory MinecraftLootFunction.fromJson(Map<String, dynamic> json) =>
//       _$MinecraftLootFunctionFromJson(json);

//   Map<String, dynamic> toJson() => _$MinecraftLootFunctionToJson(this);
// }
