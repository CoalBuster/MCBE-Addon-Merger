// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trigger _$TriggerFromJson(Map<String, dynamic> json) => Trigger(
      event: json['event'] as String,
      filters: TriggerFilter.fromJson(json['filters'] as Map<String, dynamic>),
      target: json['target'] as String,
    );

Map<String, dynamic> _$TriggerToJson(Trigger instance) => <String, dynamic>{
      'event': instance.event,
      'filters': instance.filters,
      'target': instance.target,
    };

TriggerFilter _$TriggerFilterFromJson(Map<String, dynamic> json) =>
    TriggerFilter(
      allOf: (json['all_of'] as List<dynamic>?)
          ?.map((e) => TriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      anyOf: (json['any_of'] as List<dynamic>?)
          ?.map((e) => TriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TriggerFilterToJson(TriggerFilter instance) =>
    <String, dynamic>{
      'all_of': instance.allOf,
      'any_of': instance.anyOf,
    };

TriggerCondition _$TriggerConditionFromJson(Map<String, dynamic> json) =>
    TriggerCondition(
      subject: json['subject'] as String,
      test: json['test'] as String,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$TriggerConditionToJson(TriggerCondition instance) =>
    <String, dynamic>{
      'test': instance.test,
      'subject': instance.subject,
      'value': instance.value,
    };
