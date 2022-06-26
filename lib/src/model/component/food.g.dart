// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodComponent _$FoodComponentFromJson(Map<String, dynamic> json) =>
    FoodComponent(
      nutrition: json['nutrition'] as int,
      saturationModifier:
          $enumDecode(_$SaturationEnumMap, json['saturation_modifier']),
      effects: (json['effects'] as List<dynamic>?)
          ?.map((e) => Effect.fromJson(e as Map<String, dynamic>))
          .toList(),
      onUseAction: json['on_use_action'] as String?,
      usingConvertsTo: json['using_converts_to'] as String?,
    );

Map<String, dynamic> _$FoodComponentToJson(FoodComponent instance) =>
    <String, dynamic>{
      'effects': instance.effects,
      'nutrition': instance.nutrition,
      'on_use_action': instance.onUseAction,
      'saturation_modifier': _$SaturationEnumMap[instance.saturationModifier],
      'using_converts_to': instance.usingConvertsTo,
    };

const _$SaturationEnumMap = {
  Saturation.good: 'good',
  Saturation.low: 'low',
  Saturation.normal: 'normal',
  Saturation.poor: 'poor',
  Saturation.supernatural: 'supernatural',
};
