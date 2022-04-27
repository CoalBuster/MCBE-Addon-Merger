// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftComponentFood _$MinecraftComponentFoodFromJson(
        Map<String, dynamic> json) =>
    MinecraftComponentFood(
      nutrition: json['nutrition'] as int,
      saturationModifier:
          $enumDecode(_$SaturationModifierEnumMap, json['saturation_modifier']),
      effects: (json['effects'] as List<dynamic>?)
          ?.map((e) => MinecraftEffect.fromJson(e as Map<String, dynamic>))
          .toList(),
      onUseAction: json['on_use_action'] as String?,
      usingConvertsTo: json['using_converts_to'] as String?,
    );

Map<String, dynamic> _$MinecraftComponentFoodToJson(
        MinecraftComponentFood instance) =>
    <String, dynamic>{
      'effects': instance.effects,
      'nutrition': instance.nutrition,
      'on_use_action': instance.onUseAction,
      'saturation_modifier':
          _$SaturationModifierEnumMap[instance.saturationModifier],
      'using_converts_to': instance.usingConvertsTo,
    };

const _$SaturationModifierEnumMap = {
  SaturationModifier.good: 'good',
  SaturationModifier.low: 'low',
  SaturationModifier.normal: 'normal',
  SaturationModifier.poor: 'poor',
  SaturationModifier.supernatural: 'supernatural',
};
