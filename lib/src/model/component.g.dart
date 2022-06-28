// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

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

InteractComponent _$InteractComponentFromJson(Map<String, dynamic> json) =>
    InteractComponent(
      interactions: (json['interactions'] as List<dynamic>)
          .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InteractComponentToJson(InteractComponent instance) =>
    <String, dynamic>{
      'interactions': instance.interactions,
    };

Interaction _$InteractionFromJson(Map<String, dynamic> json) => Interaction(
      hurtItem: json['hurt_item'] as int?,
      interactText: json['interact_text'] as String?,
      onInteract: Trigger.fromJson(json['on_interact'] as Map<String, dynamic>),
      playSounds: json['play_sounds'] as String?,
      swing: json['swing'] as bool? ?? false,
      useItem: json['use_item'] as bool? ?? false,
    );

Map<String, dynamic> _$InteractionToJson(Interaction instance) =>
    <String, dynamic>{
      'hurt_item': instance.hurtItem,
      'interact_text': instance.interactText,
      'on_interact': instance.onInteract,
      'play_sounds': instance.playSounds,
      'swing': instance.swing,
      'use_item': instance.useItem,
    };

SeedComponent _$SeedComponentFromJson(Map<String, dynamic> json) =>
    SeedComponent(
      cropResult: json['crop_result'] as String,
      plantAt: (json['plant_at'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SeedComponentToJson(SeedComponent instance) =>
    <String, dynamic>{
      'crop_result': instance.cropResult,
      'plant_at': instance.plantAt,
    };

UnknownComponent _$UnknownComponentFromJson(Map<String, dynamic> json) =>
    UnknownComponent(
      json: json['json'],
    );

Map<String, dynamic> _$UnknownComponentToJson(UnknownComponent instance) =>
    <String, dynamic>{
      'json': instance.json,
    };
