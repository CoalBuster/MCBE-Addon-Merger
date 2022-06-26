import 'package:json_annotation/json_annotation.dart';

part 'trigger.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Trigger {
  final String event;
  final TriggerFilter filters;
  final String target;

  Trigger({
    required this.event,
    required this.filters,
    required this.target,
  });

  factory Trigger.fromJson(Map<String, dynamic> json) =>
      _$TriggerFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerToJson(this);

  @override
  String toString() => 'When $filters, Then trigger event $event on $target';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TriggerFilter {
  final List<TriggerCondition>? allOf;
  final List<TriggerCondition>? anyOf;

  TriggerFilter({
    this.allOf,
    this.anyOf,
  });

  factory TriggerFilter.fromJson(Map<String, dynamic> json) =>
      _$TriggerFilterFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerFilterToJson(this);

  @override
  String toString() {
    if ((allOf?.isEmpty ?? true) && (anyOf?.isEmpty ?? true)) {
      return 'Always';
    }

    return (allOf?.join(' AND ') ?? '') + (anyOf?.join(' OR ') ?? '');
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TriggerCondition {
  final String test;
  final String subject;
  final String? value;

  TriggerCondition({
    required this.subject,
    required this.test,
    this.value,
  });

  factory TriggerCondition.fromJson(Map<String, dynamic> json) =>
      _$TriggerConditionFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerConditionToJson(this);

  @override
  String toString() => '$subject $test ${value ?? ''}';
}
