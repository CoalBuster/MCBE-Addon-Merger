import 'package:json_annotation/json_annotation.dart';

import 'effect.dart';
import 'saturation.dart';
import 'trigger.dart';

part 'component.g.dart';

class ComponentParam<T> {
  final String name;
  final T value;

  Type get type => T.runtimeType;

  ComponentParam(this.name, this.value);
}

abstract class Component {
  List<ComponentParam> get parameters;
  String? get name;
  String? get summary;

  dynamic toJson();
}

class Components {
  static const _components = {
    'minecraft:food': FoodComponent.fromJson,
    'minecraft:interact': InteractComponent.fromJson,
    'minecraft:seed': SeedComponent.fromJson,
  };

  const Components();

  static Map<String, Component>? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return Map.fromEntries(json.entries.map((e) => MapEntry(
          e.key,
          _components[e.key]?.call(e.value) ??
              UnknownComponent.fromJson(e.value),
        )));
  }

  static Map<String, dynamic>? toJson(Map<String, Component>? components) {
    if (components == null) {
      return null;
    }

    return Map.fromEntries(components.entries.map((e) => MapEntry(
          e.key,
          e.value.toJson(),
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
        ComponentParam('Effects', effects),
        ComponentParam('Nutrition', nutrition),
        ComponentParam('Saturation', saturationModifier),
        ComponentParam('On Use', onUseAction),
        ComponentParam('Using Converts To', usingConvertsTo),
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
      .map((e) => ComponentParam(e.interactText ?? 'Interaction', e))
      .toList();
  // [
  //       ComponentParam('Interactions', interactions),
  //     ];

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
        ComponentParam('Plant At', plantAt),
        ComponentParam('Get Crop', cropResult),
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
          .map((e) => ComponentParam(e.key, e.value))
          .toList()
      : [];

  factory UnknownComponent.fromJson(dynamic json) =>
      _$UnknownComponentFromJson({'json': json});

  @override
  dynamic toJson() => _$UnknownComponentToJson(this)['json'];

  @override
  String toString() => json.toString();
}
