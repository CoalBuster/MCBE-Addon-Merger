import 'package:json_annotation/json_annotation.dart';

import 'component.dart';
import 'loot.dart';
import 'loot_condition.dart';
import 'manifest_dependency.dart';
import 'manifest_header.dart';
import 'manifest_module.dart';
import 'module_type.dart';
import 'pack_element.dart';
import 'parameter.dart';
import 'range.dart';

part 'pack_element_json.g.dart';

abstract class PackJsonElement implements PackElement {
  String? get name => null;
  dynamic toJson();
}

class PackJsonElements
    implements
        JsonConverter<Map<String, PackJsonElement>, Map<String, dynamic>> {
  static const _elements = {
    'animation_controllers': AnimationControllersElement.fromJson,
    'animations': AnimationsElement.fromJson,
    'minecraft:entity': ServerEntityElement.fromJson,
    'minecraft:item': ItemElement.fromJson,
    'pools': LootPoolsElement.fromJson,
    'minecraft:recipe_shaped': ShapedRecipeElement.fromJson,
    'minecraft:recipe_shapeless': ShapelessRecipeElement.fromJson,
  };

  const PackJsonElements();

  @override
  Map<String, PackJsonElement> fromJson(Map<String, dynamic> json) {
    return Map.fromEntries(json.entries
        .where((e) => _elements.containsKey(e.key))
        .map((e) => MapEntry(e.key, _elements[e.key]!.call(e.value))));
  }

  @override
  Map<String, dynamic> toJson(Map<String, PackJsonElement> element) {
    return element.map((key, value) => MapEntry(key, value.toJson()));
  }
}

///
/// PackJsonElements
///

/// Collection of animation controllers
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllersElement extends PackJsonElement {
  final Map<String, AnimationControllerEntry> controllers;

  AnimationControllersElement({
    required this.controllers,
  });

  @override
  List<Parameter> get parameters =>
      controllers.keys.map((key) => Parameter(key, '/$key')).toList();

  @override
  PackElementCategory get category => PackElementCategory.animationControllers;

  factory AnimationControllersElement.fromJson(dynamic json) =>
      _$AnimationControllersElementFromJson({'controllers': json});

  @override
  dynamic toJson() => _$AnimationControllersElementToJson(this)['controllers'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllerEntry implements Parameterized {
  final String? initialState;
  final Map<String, AnimationControllerState> states;

  AnimationControllerEntry({
    required this.initialState,
    required this.states,
  });

  @override
  List<Parameter> get parameters => [
        if (initialState != null) Parameter('Initial State', '/initial_state'),
        Parameter('States', '/states'),
      ];

  factory AnimationControllerEntry.fromJson(Map<String, dynamic> json) =>
      _$AnimationControllerEntryFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationControllerEntryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllerState implements Parameterized {
  final List<String>? animations;
  final List<String>? onEntry;
  final List<AnimationControllerTransition>? transitions;

  AnimationControllerState({
    required this.animations,
    required this.onEntry,
    required this.transitions,
  });

  @override
  List<Parameter> get parameters => [
        if (animations != null) Parameter('Animations', '/animations'),
        if (onEntry != null) Parameter('On Entry', '/on_entry'),
        if (transitions != null) Parameter('Transitions', '/transitions')
      ];

  factory AnimationControllerState.fromJson(Map<String, dynamic> json) =>
      _$AnimationControllerStateFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationControllerStateToJson(this);
}

class AnimationControllerTransition implements Named {
  final String condition;
  final String state;

  AnimationControllerTransition({
    required this.condition,
    required this.state,
  });

  @override
  get name => '-> \'$state\'';

  @override
  get value => 'Condition: $condition';

  factory AnimationControllerTransition.fromJson(Map<String, dynamic> json) =>
      json.entries
          .map((e) => AnimationControllerTransition(
                condition: e.value,
                state: e.key,
              ))
          .single;

  Map<String, dynamic> toJson() => {state: condition};
}

/// Collection of animations
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationsElement extends PackJsonElement {
  final Map<String, AnimationEntry> animations;

  AnimationsElement({
    required this.animations,
  });

  @override
  List<Parameter> get parameters =>
      animations.keys.map((key) => Parameter(key, '/$key')).toList();

  @override
  PackElementCategory get category => PackElementCategory.animations;

  factory AnimationsElement.fromJson(dynamic json) =>
      _$AnimationsElementFromJson({'animations': json});

  @override
  dynamic toJson() => _$AnimationsElementToJson(this)['animations'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationEntry implements Parameterized {
  final double animationLength;
  final bool loop;
  final Map<String, SingleOrList<String>> timeline;

  AnimationEntry({
    required this.animationLength,
    required this.loop,
    required this.timeline,
  });

  @override
  List<Parameter> get parameters => [
        Parameter<Map<String, dynamic>>('Loop Animation', '/loop'),
        Parameter<Map<String, dynamic>>('Duration', '/animation_length'),
        Parameter<Map<String, dynamic>>('Timeline', '/timeline'),
      ];

  factory AnimationEntry.fromJson(Map<String, dynamic> json) =>
      _$AnimationEntryFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationEntryToJson(this);
}

/// Item
@JsonSerializable(fieldRename: FieldRename.snake)
class ItemElement extends PackJsonElement {
  @Components()
  final Map<String, Component>? components;
  final ItemDescription description;

  ItemElement({
    required this.components,
    required this.description,
  });

  @override
  List<Parameter> get parameters => [
        Parameter<String>('Identifier', '/description/identifier'),
        Parameter('Components', '/components'),
      ];

  @override
  PackElementCategory get category => PackElementCategory.item;

  @override
  String? get name => description.identifier;

  factory ItemElement.fromJson(dynamic json) => _$ItemElementFromJson(json);

  @override
  dynamic toJson() => _$ItemElementToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemDescription {
  final String? category;
  final String identifier;

  ItemDescription({
    required this.identifier,
    this.category,
  });

  factory ItemDescription.fromJson(Map<String, dynamic> json) =>
      _$ItemDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDescriptionToJson(this);
}

/// Loot
@JsonSerializable(fieldRename: FieldRename.snake)
class LootPoolsElement extends PackJsonElement {
  final List<LootTable> pools;

  LootPoolsElement({
    required this.pools,
  });

  @override
  List<Parameter> get parameters => pools
      .asMap()
      .keys
      .map((key) => Parameter<Map<String, dynamic>>('Pool ${key + 1}', '/$key'))
      .toList();

  @override
  PackElementCategory get category => PackElementCategory.lootTable;

  factory LootPoolsElement.fromJson(dynamic json) =>
      _$LootPoolsElementFromJson({'pools': json});

  @override
  dynamic toJson() => _$LootPoolsElementToJson(this)['pools'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootTable implements Parameterized {
  @LootConditions()
  final List<LootCondition>? conditions;
  final List<LootEntry>? entries;
  final CountOrRange? rolls;
  final LootTier? tiers;

  LootTable({
    this.entries,
    this.conditions,
    this.rolls,
    this.tiers,
  });

  bool get isEmpty =>
      entries == null || entries!.isEmpty || (rolls == null && tiers == null);

  bool get isTiered => tiers != null;

  @override
  List<Parameter> get parameters => [
        Parameter('Amount of rolls', '/rolls'),
        Parameter('Tiers', '/tiers'),
        Parameter('Conditions', '/conditions'),
        Parameter('Loot table entries', '/entries'),
      ];

  int get totalWeight =>
      entries
          ?.map((e) => e.weight)
          .reduce((value, element) => value + element) ??
      0;

  factory LootTable.fromJson(Map<String, dynamic> json) =>
      _$LootTableFromJson(json);

  Map<String, dynamic> toJson() => _$LootTableToJson(this);
}

/// Server-side entity
@JsonSerializable(fieldRename: FieldRename.snake)
class ServerEntityElement extends PackJsonElement {
  @ComponentGroups()
  final Map<String, Map<String, Component>>? componentGroups;
  @Components()
  final Map<String, Component>? components;
  final ServerEntityDescription description;

  ServerEntityElement({
    required this.componentGroups,
    required this.components,
    required this.description,
  });

  Map<String, Map<String, Component>?>? get groups => componentGroups
      ?.map((key, value) => MapEntry(key, const Components().fromJson(value)));

  @override
  List<Parameter> get parameters => [
        Parameter<String>('Identifier', '/description/identifier'),
        Parameter<bool>('Is Spawnable', '/description/is_spawnable'),
        Parameter<bool>('Can be summoned', '/description/is_summonable'),
        Parameter<bool>('Is Experimental', '/description/is_experimental'),
        Parameter<Map<String, dynamic>>(
            'Animations', '/description/animations'),
        Parameter<bool>('Scripts', '/description/scripts'),
        Parameter('Components', '/components'),
        Parameter('Component Groups', '/component_groups'),
      ];

  @override
  PackElementCategory get category => PackElementCategory.entity;

  @override
  String? get name => description.identifier;

  factory ServerEntityElement.fromJson(dynamic json) =>
      _$ServerEntityElementFromJson(json);

  @override
  dynamic toJson() => _$ServerEntityElementToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerEntityDescription {
  Map<String, String>? animations;
  String identifier;
  bool? isSpawnable;
  bool? isSummonable;
  bool? isExperimental;
  ServerEntityScripts? scripts;

  ServerEntityDescription({
    required this.identifier,
    this.animations,
    this.isExperimental,
    this.isSpawnable,
    this.isSummonable,
    this.scripts,
  });

  factory ServerEntityDescription.fromJson(Map<String, dynamic> json) =>
      _$ServerEntityDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ServerEntityDescriptionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerEntityScripts {
  final List<String>? animate;

  ServerEntityScripts({
    this.animate,
  });

  factory ServerEntityScripts.fromJson(Map<String, dynamic> json) =>
      _$ServerEntityScriptsFromJson(json);

  Map<String, dynamic> toJson() => _$ServerEntityScriptsToJson(this);
}

/// Recipes
@JsonSerializable(fieldRename: FieldRename.snake)
class ShapedRecipeElement extends PackJsonElement {
  final RecipeDescription description;
  final String? group;
  final Map<String, RecipeIngredient> key;
  final List<String> pattern;
  // @SingleOrList<RecipeResult>(RecipeResult.fromJson)
  final SingleOrList<RecipeResult> result;
  final List<String> tags;

  ShapedRecipeElement({
    required this.description,
    required this.key,
    required this.pattern,
    required this.result,
    required this.tags,
    this.group,
  });

  @override
  List<Parameter> get parameters => [
        Parameter('Shaped Recipe', '/description/identifier'),
        Parameter('Group', '/group'),
        Parameter('Tags', '/tags'),
        Parameter('Legenda', '/key'),
        Parameter('Pattern', '/pattern'),
        Parameter('Result', '/result'),
      ];

  @override
  PackElementCategory get category => PackElementCategory.recipe;

  @override
  String? get name => description.identifier;

  factory ShapedRecipeElement.fromJson(dynamic json) =>
      _$ShapedRecipeElementFromJson(json);

  @override
  dynamic toJson() => _$ShapedRecipeElementToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ShapelessRecipeElement extends PackJsonElement {
  final RecipeDescription description;
  final List<RecipeIngredient> ingredients;
  final RecipeResult result;
  final List<String> tags;

  ShapelessRecipeElement({
    required this.description,
    required this.ingredients,
    required this.result,
    required this.tags,
  });

  @override
  List<Parameter> get parameters => [
        Parameter('Shapeless Recipe', '/description/identifier'),
        Parameter('Tags', '/tags'),
        Parameter('Ingredients', '/ingredients'),
        Parameter('Result', '/result'),
      ];

  @override
  PackElementCategory get category => PackElementCategory.recipe;

  @override
  String? get name => description.identifier;

  factory ShapelessRecipeElement.fromJson(dynamic json) =>
      _$ShapelessRecipeElementFromJson(json);

  @override
  dynamic toJson() => _$ShapelessRecipeElementToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RecipeDescription {
  String identifier;

  RecipeDescription({
    required this.identifier,
  });

  factory RecipeDescription.fromJson(Map<String, dynamic> json) =>
      _$RecipeDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeDescriptionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RecipeIngredient {
  int? count;
  int? data;
  String item;

  RecipeIngredient({
    required this.item,
    this.count,
    this.data,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeIngredientToJson(this);

  @override
  String toString() =>
      item +
      (data == null ? '' : ' (data: $data)') +
      (count == null ? '' : ' x$count');
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RecipeResult {
  int count;
  int? data;
  String item;

  RecipeResult({
    required this.item,
    this.count = 1,
    this.data,
  });

  factory RecipeResult.fromJson(dynamic json) => _$RecipeResultFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeResultToJson(this);

  @override
  String toString() => '${count}x $item${data == null ? '' : ' (data: $data)'}';
}

/// Unknown element
class UnknownElement extends PackJsonElement {
  final Map<String, dynamic> json;

  UnknownElement({
    required this.json,
  });

  @override
  List<Parameter> get parameters => [
        Parameter<dynamic>('json', '/'),
      ];

  @override
  PackElementCategory get category => PackElementCategory.unknown;

  factory UnknownElement.fromJson(dynamic json) => UnknownElement(json: json);

  @override
  dynamic toJson() => json;
}
