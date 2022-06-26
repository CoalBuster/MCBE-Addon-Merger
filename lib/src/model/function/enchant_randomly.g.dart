// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enchant_randomly.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootFunctionEnchantRandomly _$LootFunctionEnchantRandomlyFromJson(
        Map<String, dynamic> json) =>
    LootFunctionEnchantRandomly(
      function: json['function'] as String,
      chance: (json['chance'] as num?)?.toDouble(),
      levels:
          json['levels'] == null ? null : CountOrRange.fromJson(json['levels']),
      treasure: json['treasure'] as bool? ?? false,
    );

Map<String, dynamic> _$LootFunctionEnchantRandomlyToJson(
        LootFunctionEnchantRandomly instance) =>
    <String, dynamic>{
      'function': instance.function,
      'chance': instance.chance,
      'levels': instance.levels,
      'treasure': instance.treasure,
    };
