import 'package:json_annotation/json_annotation.dart';
import 'package:mcbe_addon_merger/src/model/parameter.dart';

import 'effect.dart';
import 'saturation.dart';
import 'trigger.dart';

part 'component.g.dart';

abstract class Component implements Parameterized {
  String? get name;
  String? get summary;

  dynamic toJson();
}

class ComponentGroups extends JsonConverter<
    Map<String, Map<String, Component>>?, Map<String, dynamic>?> {
  const ComponentGroups();

  @override
  Map<String, Map<String, Component>>? fromJson(Map<String, dynamic>? json) =>
      json?.map(
          (key, value) => MapEntry(key, const Components().fromJson(value)!));

  @override
  Map<String, dynamic>? toJson(Map<String, Map<String, Component>>? object) =>
      object?.map(
          (key, value) => MapEntry(key, const Components().toJson(value)));
}

class Components
    extends JsonConverter<Map<String, Component>?, Map<String, dynamic>?> {
  static const _components = {
    'minecraft:food': FoodComponent.fromJson,
    'minecraft:interact': InteractComponent.fromJson,
    'minecraft:insomnia': InsomniaComponent.fromJson,
    'minecraft:pushable': PushableComponent.fromJson,
    'minecraft:seed': SeedComponent.fromJson,
  };

  const Components();

  @override
  Map<String, Component>? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return Map.fromEntries(json.entries.map((e) => MapEntry(
          e.key,
          _components[e.key]?.call(e.value) ??
              UnknownComponent.fromJson(e.value),
        )));
  }

  @override
  Map<String, dynamic>? toJson(Map<String, Component>? object) {
    if (object == null) {
      return null;
    }

    return Map.fromEntries(object.entries.map((e) => MapEntry(
          e.key,
          e.value,
        )));
  }
}

///
/// Components
///

/// Item that can be consumed as Food
@JsonSerializable(fieldRename: FieldRename.snake)
class FoodComponent implements Component {
  final List<Effect>? effects;
  final int nutrition;
  final String? onUseAction;
  final Saturation saturationModifier;
  final String? usingConvertsTo;

  FoodComponent({
    required this.nutrition,
    required this.saturationModifier,
    this.effects,
    this.onUseAction,
    this.usingConvertsTo,
  });

  @override
  get name => 'Food';

  @override
  get summary => null;

  @override
  get parameters => [
        Parameter<List<Effect>>('Effects', '/effects'),
        Parameter<int>('Nutrition', '/nutrition'),
        Parameter<Saturation>('Saturation', '/saturation_modifier'),
        Parameter<String>('On Use', '/on_use_action'),
        Parameter<String>('Using Converts To', '/using_converts_to'),
      ];

  factory FoodComponent.fromJson(Map<String, dynamic> json) =>
      _$FoodComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FoodComponentToJson(this);
}

/// Entity that can be interacted with
@JsonSerializable(fieldRename: FieldRename.snake)
class InteractComponent implements Component {
  final List<Interaction> interactions;

  InteractComponent({
    required this.interactions,
  });

  @override
  get name => 'Interactable';

  @override
  get summary => '${interactions.length} interaction(s)';

  @override
  get parameters => interactions
      .asMap()
      .entries
      .map((e) => Parameter<Interaction>(
          e.value.interactText ?? 'Nameless interaction',
          '/interactions/${e.key}'))
      .toList();

  factory InteractComponent.fromJson(Map<String, dynamic> json) {
    if (json['interactions'] is Map<String, dynamic>) {
      json['interactions'] = [json['interactions']];
    }
    return _$InteractComponentFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$InteractComponentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Interaction {
  final int? hurtItem;
  final String? interactText;
  final Trigger onInteract;
  final String? playSounds;
  final bool swing;
  final bool useItem;

  Interaction({
    required this.hurtItem,
    required this.interactText,
    required this.onInteract,
    this.playSounds,
    this.swing = false,
    this.useItem = false,
  });

  factory Interaction.fromJson(Map<String, dynamic> json) =>
      _$InteractionFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionToJson(this);

  @override
  String toString() =>
      'Condition: ${onInteract.filters}' +
      (onInteract.event == null
          ? ''
          : '\nEvent: ${onInteract.event} on ${onInteract.target ?? 'self'}');
}

/// Entity experiences insomnia
@JsonSerializable(fieldRename: FieldRename.snake)
class InsomniaComponent implements Component {
  final int daysUntilInsomnia;

  InsomniaComponent({
    required this.daysUntilInsomnia,
  });

  @override
  String? get name => 'Insomnia';

  @override
  List<Parameter> get parameters => [
        Parameter<int>('Days until insomnia', '/days_until_insomnia'),
      ];

  @override
  String? get summary => 'Phantoms after $daysUntilInsomnia days';

  factory InsomniaComponent.fromJson(Map<String, dynamic> json) =>
      _$InsomniaComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InsomniaComponentToJson(this);
}

/// Entity can be pushed around
@JsonSerializable(fieldRename: FieldRename.snake)
class PushableComponent implements Component {
  final bool isPushable;
  final bool isPushableByPiston;

  PushableComponent({
    required this.isPushable,
    required this.isPushableByPiston,
  });

  @override
  String? get name => 'Pushable';

  @override
  List<Parameter> get parameters => [
        Parameter<bool>('Pushable', '/is_pushable'),
        Parameter<bool>('Pushable by piston', '/is_pushable_by_piston')
      ];

  @override
  String? get summary => isPushable
      ? isPushableByPiston
          ? 'Pushable, also by piston'
          : 'Pushable, but not by piston'
      : isPushableByPiston
          ? 'Only pushable by piston'
          : 'Not pushable';

  factory PushableComponent.fromJson(Map<String, dynamic> json) =>
      _$PushableComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PushableComponentToJson(this);
}

/// Item that can be planted
@JsonSerializable(fieldRename: FieldRename.snake)
class SeedComponent implements Component {
  final String cropResult;
  final List<String>? plantAt;

  SeedComponent({
    required this.cropResult,
    required this.plantAt,
  });

  @override
  get name => 'Seed';

  @override
  get summary => toString();

  @override
  get parameters => [
        Parameter<List<String>>('Plant At', '/plant_at'),
        Parameter<String>('Get Crop', '/crop_result'),
      ];

  factory SeedComponent.fromJson(Map<String, dynamic> json) {
    if (json['plant_at'] is String) {
      json['plant_at'] = [json['plant_at']];
    }
    return _$SeedComponentFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SeedComponentToJson(this);

  @override
  String toString() =>
      'Plant${plantAt == null ? '' : ' on ${plantAt!.join(' or ')}'} '
      'to grow $cropResult';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UnknownComponent extends Component {
  final dynamic json;

  UnknownComponent({
    required this.json,
  });

  @override
  get name => null;

  @override
  get summary => null;

  @override
  get parameters => json is Map<String, dynamic>
      ? (json as Map<String, dynamic>)
          .entries
          .map((e) => Parameter(e.key, '/${e.key}'))
          .toList()
      : [];

  factory UnknownComponent.fromJson(dynamic json) =>
      _$UnknownComponentFromJson({'json': json});

  @override
  dynamic toJson() => _$UnknownComponentToJson(this)['json'];

  @override
  String toString() => json.toString();
}
