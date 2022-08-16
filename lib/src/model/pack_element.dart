import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'component.dart';
import 'loot.dart';
import 'loot_condition.dart';
import 'range.dart';
import 'version.dart';

part 'pack_element.g.dart';

enum PackElementType {
  animationControllers,
  animations,
  entity,
  image,
  item,
  lootTable,
  recipeShaped,
  recipeShapeless,
  unknown;

  String asString() {
    switch (this) {
      case PackElementType.animationControllers:
        return 'Animation Controller';
      case PackElementType.animations:
        return 'Animation';
      case PackElementType.entity:
        return 'Entity';
      case PackElementType.image:
        return 'Image';
      case PackElementType.item:
        return 'Item';
      case PackElementType.lootTable:
        return 'Loot Table';
      case PackElementType.recipeShaped:
      case PackElementType.recipeShapeless:
        return 'Recipe';
      case PackElementType.unknown:
        return 'Unknown';
    }
  }

  static PackElementType? fromJson(Map<String, dynamic> json) {
    if (json['animation_controllers'] is Map<String, dynamic>) {
      return PackElementType.animationControllers;
    }

    if (json['animations'] is Map<String, dynamic>) {
      return PackElementType.animations;
    }

    if (json['minecraft:entity'] is Map<String, dynamic>) {
      return PackElementType.entity;
    }

    if (json['minecraft:item'] is Map<String, dynamic>) {
      return PackElementType.item;
    }

    if (json['pools'] is List<dynamic>) {
      return PackElementType.lootTable;
    }

    if (json['minecraft:recipe_shaped'] is Map<String, dynamic>) {
      return PackElementType.recipeShaped;
    }

    if (json['minecraft:recipe_shapeless'] is Map<String, dynamic>) {
      return PackElementType.recipeShapeless;
    }

    return null;
  }

  // String jsonKey() {
  //   switch (this) {
  //     case PackElementType.animationControllers:
  //       return 'animation_controllers';
  //     case PackElementType.animations:
  //       return 'animations';
  //     case PackElementType.entity:
  //       return 'minecraft:entity';
  //     case PackElementType.item:
  //       return 'minecraft:item';
  //     case PackElementType.lootTable:
  //       return 'pools';
  //     case PackElementType.recipeShaped:
  //       return 'minecraft:recipe_shaped';
  //     case PackElementType.recipeShapeless:
  //       return 'minecraft:recipe_shapeless';
  //     default:
  //       throw 'Non json';
  //   }
  // }

  String? nameFromJson(Map<String, dynamic> json) {
    switch (this) {
      case PackElementType.animationControllers:
        return json['animation_controllers'].keys.join(', ');
      case PackElementType.animations:
        return json['animations'].keys.join(', ');
      case PackElementType.entity:
        return json['minecraft:entity']['description']['identifier'];
      case PackElementType.item:
        return json['minecraft:item']['description']['identifier'];
      case PackElementType.recipeShaped:
        return json['minecraft:recipe_shaped']['description']['identifier'];
      case PackElementType.recipeShapeless:
        return json['minecraft:recipe_shapeless']['description']['identifier'];
      default:
        return null;
    }
  }
}

class PackElementInfo {
  final Version? formatVersion;
  final String? name;
  final String path;
  final PackElementType type;

  PackElementInfo({
    required this.path,
    required this.type,
    this.formatVersion,
    this.name,
  });
}

abstract class PackElement {
  @JsonKey(ignore: true)
  String get type;

  PackElement();

  dynamic toJson();
}

class PackElements implements JsonConverter<PackElement, Map<String, dynamic>> {
  static const _elements = {
    'animation_controllers': AnimationControllersElement.fromJson,
    'animations': AnimationsElement.fromJson,
    'minecraft:entity': ServerEntityElement.fromJson,
    'minecraft:item': ItemElement.fromJson,
    'pools': LootPoolsElement.fromJson,
    'minecraft:recipe_shaped': ShapedRecipeElement.fromJson,
    'minecraft:recipe_shapeless': ShapelessRecipeElement.fromJson,
  };

  const PackElements();

  @override
  PackElement fromJson(Map<String, dynamic> json) {
    final type = _elements.keys.firstWhereOrNull((e) => json.keys.contains(e));
    // Map<String, dynamic> value = {'type': type};

    // if (json[type] is Map<String, dynamic>) {
    //   value.addAll(json[type]);
    // } else {
    //   value['value'] = json[type];
    // }

    return _elements[type]?.call(json[type]) ?? UnknownElement.fromJson(json);

    // return Map.fromEntries(json.entries.map((e) {
    //   final value = {'type': e.key};

    //   if (e.value is Map<String, dynamic>) {
    //     value.addAll(e.value);
    //   } else {
    //     value['value'] = e.value;
    //   }

    //   return MapEntry(
    //     e.key,
    //     _elements[e.key]?.call(value) ?? UnknownElement.fromJson(value),
    //   );
    // }));

    // final type = PackElementType.fromJson(json);
    // return _elements[type]?.call(json[type!.jsonKey()]) ??
    //     UnknownElement(
    //       json: json,
    //     );
  }

  @override
  Map<String, dynamic> toJson(PackElement element) {
    // return Map.fromEntries(element.entries.map((e) => MapEntry(
    //       e.key,
    //       e.value.toJson(),
    //     )));
    return element.toJson();
  }
}

///
/// PackElements
///

/// Collection of animation controllers
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllersElement extends PackElement {
  final Map<String, AnimationControllerEntry> controllers;

  AnimationControllersElement({
    required this.controllers,
    // required super.type,
  });

  @override
  String get type => 'animation_controllers';

  factory AnimationControllersElement.fromJson(dynamic json) =>
      _$AnimationControllersElementFromJson({'controllers': json});

  @override
  dynamic toJson() => _$AnimationControllersElementToJson(this)['controllers'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllerEntry {
  final Map<String, AnimationControllerState> states;

  AnimationControllerEntry({
    required this.states,
  });

  factory AnimationControllerEntry.fromJson(Map<String, dynamic> json) =>
      _$AnimationControllerEntryFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationControllerEntryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllerState {
  final List<Map<String, String>>? transitions;

  AnimationControllerState({
    required this.transitions,
  });

  factory AnimationControllerState.fromJson(Map<String, dynamic> json) =>
      _$AnimationControllerStateFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationControllerStateToJson(this);
}

/// Collection of animations
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationsElement extends PackElement {
  final Map<String, AnimationEntry> animations;

  AnimationsElement({
    required this.animations,
    // required super.type,
  });

  @override
  String get type => 'animations';

  factory AnimationsElement.fromJson(dynamic json) =>
      _$AnimationsElementFromJson({'animations': json});

  @override
  dynamic toJson() => _$AnimationsElementToJson(this)['animations'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationEntry {
  final double animationLength;
  final bool loop;
  final Map<String, SingleOrList<String>> timeline;

  AnimationEntry({
    required this.animationLength,
    required this.loop,
    required this.timeline,
  });

  factory AnimationEntry.fromJson(Map<String, dynamic> json) =>
      _$AnimationEntryFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationEntryToJson(this);
}

/// Item
@JsonSerializable(fieldRename: FieldRename.snake)
class ItemElement extends PackElement {
  @JsonKey(fromJson: Components.fromJson, toJson: Components.toJson)
  final Map<String, Component>? components;
  final ItemDescription description;

  ItemElement({
    required this.components,
    required this.description,
    // required super.type,
  });

  @override
  String get type => 'minecraft:item';

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
class LootPoolsElement extends PackElement {
  final List<LootTable> pools;

  LootPoolsElement({
    required this.pools,
    // required super.type,
  });

  @override
  String get type => 'pools';

  factory LootPoolsElement.fromJson(dynamic json) =>
      _$LootPoolsElementFromJson({'pools': json});

  @override
  dynamic toJson() => _$LootPoolsElementToJson(this)['pools'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootTable {
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
class ServerEntityElement extends PackElement {
  final Map<String, dynamic>? componentGroups;
  @JsonKey(fromJson: Components.fromJson, toJson: Components.toJson)
  final Map<String, Component>? components;
  final ServerEntityDescription description;

  ServerEntityElement({
    required this.componentGroups,
    required this.components,
    required this.description,
    // required super.type,
  });

  @override
  String get type => 'minecraft:entity';

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
class ShapedRecipeElement extends PackElement {
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
    // required super.type,
    this.group,
  });

  @override
  String get type => 'minecraft:recipe_shaped';

  factory ShapedRecipeElement.fromJson(dynamic json) =>
      _$ShapedRecipeElementFromJson(json);

  @override
  dynamic toJson() => _$ShapedRecipeElementToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ShapelessRecipeElement extends PackElement {
  final RecipeDescription description;
  final List<RecipeIngredient> ingredients;
  final RecipeResult result;
  final List<String> tags;

  ShapelessRecipeElement({
    required this.description,
    required this.ingredients,
    required this.result,
    required this.tags,
    // required super.type,
  });

  @override
  String get type => 'minecraft:recipe_shapeless';

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
class UnknownElement extends PackElement {
  final Map<String, dynamic> json;

  UnknownElement({
    required this.json,
  });

  @override
  String get type => 'unknown';

  factory UnknownElement.fromJson(dynamic json) => UnknownElement(json: json);

  @override
  dynamic toJson() => json;
}
