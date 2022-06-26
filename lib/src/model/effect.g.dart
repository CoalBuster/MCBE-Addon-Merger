// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Effect _$EffectFromJson(Map<String, dynamic> json) => Effect(
      amplifier: json['amplifier'] as int,
      chance: (json['chance'] as num?)?.toDouble(),
      duration: json['duration'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EffectToJson(Effect instance) => <String, dynamic>{
      'amplifier': instance.amplifier,
      'chance': instance.chance,
      'duration': instance.duration,
      'name': instance.name,
    };
