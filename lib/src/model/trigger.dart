import 'package:json_annotation/json_annotation.dart';

part 'trigger.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Trigger {
  final String? event;
  final TriggerCondition filters;
  final String? target;

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
class TriggerCondition {
  final List<TriggerCondition>? allOf;
  final List<TriggerCondition>? anyOf;
  final String? domain;
  final String? operator;
  final String? subject;
  final String? test;
  final dynamic value;

  TriggerCondition({
    required this.test,
    this.allOf,
    this.anyOf,
    this.domain,
    this.operator,
    this.subject,
    this.value,
  }) {
    if (test == null && _isCondition) {
      throw StateError(
          "Condition must contain either 'test' or an 'allOf/anyOf'");
    }
  }

  bool get _isCondition => (allOf?.isEmpty ?? true) && (anyOf?.isEmpty ?? true);

  factory TriggerCondition.fromJson(Map<String, dynamic> json) =>
      _$TriggerConditionFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerConditionToJson(this);

  @override
  String toString() {
    if (_isCondition) {
      return '${subject == null ? 'this' : domain == null ? subject : "$subject's $domain"}'
          ' $test ${operator == null ? value : '$operator $value'}';
    }

    return (allOf?.join(' AND ') ?? '') + (anyOf?.join(' OR ') ?? '');
  }
}
