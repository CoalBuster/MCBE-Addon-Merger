// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftEffect _$MinecraftEffectFromJson(Map<String, dynamic> json) =>
    MinecraftEffect(
      amplifier: json['amplifier'] as int,
      chance: (json['chance'] as num?)?.toDouble(),
      duration: json['duration'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MinecraftEffectToJson(MinecraftEffect instance) =>
    <String, dynamic>{
      'amplifier': instance.amplifier,
      'chance': instance.chance,
      'duration': instance.duration,
      'name': instance.name,
    };
