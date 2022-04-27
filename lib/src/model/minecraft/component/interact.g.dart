// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftComponentInteract _$MinecraftComponentInteractFromJson(
        Map<String, dynamic> json) =>
    MinecraftComponentInteract(
      interactions: (json['interactions'] as List<dynamic>)
          .map((e) => MinecraftInteraction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MinecraftComponentInteractToJson(
        MinecraftComponentInteract instance) =>
    <String, dynamic>{
      'interactions': instance.interactions,
    };

MinecraftInteraction _$MinecraftInteractionFromJson(
        Map<String, dynamic> json) =>
    MinecraftInteraction(
      hurtItem: json['hurt_item'] as int,
      interactText: json['interact_text'] as String,
      onInteract: MinecraftTrigger.fromJson(
          json['on_interact'] as Map<String, dynamic>),
      playSounds: json['play_sounds'] as String?,
      swing: json['swing'] as bool? ?? false,
      useItem: json['use_item'] as bool? ?? false,
    );

Map<String, dynamic> _$MinecraftInteractionToJson(
        MinecraftInteraction instance) =>
    <String, dynamic>{
      'hurt_item': instance.hurtItem,
      'interact_text': instance.interactText,
      'on_interact': instance.onInteract,
      'play_sounds': instance.playSounds,
      'swing': instance.swing,
      'use_item': instance.useItem,
    };
