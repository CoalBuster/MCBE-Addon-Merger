// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftTrigger _$MinecraftTriggerFromJson(Map<String, dynamic> json) =>
    MinecraftTrigger(
      event: json['event'] as String,
      filters: MinecraftTriggerFilter.fromJson(
          json['filters'] as Map<String, dynamic>),
      target: json['target'] as String,
    );

Map<String, dynamic> _$MinecraftTriggerToJson(MinecraftTrigger instance) =>
    <String, dynamic>{
      'event': instance.event,
      'filters': instance.filters,
      'target': instance.target,
    };

MinecraftTriggerFilter _$MinecraftTriggerFilterFromJson(
        Map<String, dynamic> json) =>
    MinecraftTriggerFilter(
      allOf: (json['all_of'] as List<dynamic>?)
          ?.map((e) =>
              MinecraftTriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      anyOf: (json['any_of'] as List<dynamic>?)
          ?.map((e) =>
              MinecraftTriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MinecraftTriggerFilterToJson(
        MinecraftTriggerFilter instance) =>
    <String, dynamic>{
      'all_of': instance.allOf,
      'any_of': instance.anyOf,
    };

MinecraftTriggerCondition _$MinecraftTriggerConditionFromJson(
        Map<String, dynamic> json) =>
    MinecraftTriggerCondition(
      subject: json['subject'] as String,
      test: json['test'] as String,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$MinecraftTriggerConditionToJson(
        MinecraftTriggerCondition instance) =>
    <String, dynamic>{
      'test': instance.test,
      'subject': instance.subject,
      'value': instance.value,
    };
