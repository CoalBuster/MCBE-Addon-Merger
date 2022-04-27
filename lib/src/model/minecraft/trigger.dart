import 'package:json_annotation/json_annotation.dart';

part 'trigger.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftTrigger {
  final String event;
  final MinecraftTriggerFilter filters;
  final String target;

  MinecraftTrigger({
    required this.event,
    required this.filters,
    required this.target,
  });

  factory MinecraftTrigger.fromJson(Map<String, dynamic> json) =>
      _$MinecraftTriggerFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftTriggerToJson(this);

  @override
  String toString() => 'When $filters, Then trigger event $event on $target';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftTriggerFilter {
  final List<MinecraftTriggerCondition>? allOf;
  final List<MinecraftTriggerCondition>? anyOf;

  MinecraftTriggerFilter({
    this.allOf,
    this.anyOf,
  });

  factory MinecraftTriggerFilter.fromJson(Map<String, dynamic> json) =>
      _$MinecraftTriggerFilterFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftTriggerFilterToJson(this);

  @override
  String toString() {
    if ((allOf?.isEmpty ?? true) && (anyOf?.isEmpty ?? true)) {
      return 'Always';
    }

    return (allOf?.join(' AND ') ?? '') + (anyOf?.join(' OR ') ?? '');
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftTriggerCondition {
  final String test;
  final String subject;
  final String? value;

  MinecraftTriggerCondition({
    required this.subject,
    required this.test,
    this.value,
  });

  factory MinecraftTriggerCondition.fromJson(Map<String, dynamic> json) =>
      _$MinecraftTriggerConditionFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftTriggerConditionToJson(this);

  @override
  String toString() => '$subject $test ${value ?? ''}';
}
