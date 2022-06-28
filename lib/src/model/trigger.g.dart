// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trigger _$TriggerFromJson(Map<String, dynamic> json) => Trigger(
      event: json['event'] as String?,
      filters:
          TriggerCondition.fromJson(json['filters'] as Map<String, dynamic>),
      target: json['target'] as String?,
    );

Map<String, dynamic> _$TriggerToJson(Trigger instance) => <String, dynamic>{
      'event': instance.event,
      'filters': instance.filters,
      'target': instance.target,
    };

TriggerCondition _$TriggerConditionFromJson(Map<String, dynamic> json) =>
    TriggerCondition(
      test: json['test'] as String?,
      allOf: (json['all_of'] as List<dynamic>?)
          ?.map((e) => TriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      anyOf: (json['any_of'] as List<dynamic>?)
          ?.map((e) => TriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      domain: json['domain'] as String?,
      operator: json['operator'] as String?,
      subject: json['subject'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$TriggerConditionToJson(TriggerCondition instance) =>
    <String, dynamic>{
      'all_of': instance.allOf,
      'any_of': instance.anyOf,
      'domain': instance.domain,
      'operator': instance.operator,
      'subject': instance.subject,
      'test': instance.test,
      'value': instance.value,
    };
