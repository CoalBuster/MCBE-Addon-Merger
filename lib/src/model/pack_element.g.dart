// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimationControllersElement _$AnimationControllersElementFromJson(
        Map<String, dynamic> json) =>
    AnimationControllersElement(
      controllers: (json['controllers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, AnimationControllerEntry.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AnimationControllersElementToJson(
        AnimationControllersElement instance) =>
    <String, dynamic>{
      'controllers': instance.controllers,
    };

AnimationControllerEntry _$AnimationControllerEntryFromJson(
        Map<String, dynamic> json) =>
    AnimationControllerEntry(
      initialState: json['initial_state'] as String?,
      states: (json['states'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, AnimationControllerState.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AnimationControllerEntryToJson(
        AnimationControllerEntry instance) =>
    <String, dynamic>{
      'initial_state': instance.initialState,
      'states': instance.states,
    };

AnimationControllerState _$AnimationControllerStateFromJson(
        Map<String, dynamic> json) =>
    AnimationControllerState(
      animations: (json['animations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      onEntry: (json['on_entry'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      transitions: (json['transitions'] as List<dynamic>?)
          ?.map((e) =>
              AnimationControllerTransition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimationControllerStateToJson(
        AnimationControllerState instance) =>
    <String, dynamic>{
      'animations': instance.animations,
      'on_entry': instance.onEntry,
      'transitions': instance.transitions,
    };

AnimationsElement _$AnimationsElementFromJson(Map<String, dynamic> json) =>
    AnimationsElement(
      animations: (json['animations'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, AnimationEntry.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AnimationsElementToJson(AnimationsElement instance) =>
    <String, dynamic>{
      'animations': instance.animations,
    };

AnimationEntry _$AnimationEntryFromJson(Map<String, dynamic> json) =>
    AnimationEntry(
      animationLength: (json['animation_length'] as num).toDouble(),
      loop: json['loop'] as bool,
      timeline: (json['timeline'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, SingleOrList<String>.fromJson(e, (value) => value as String)),
      ),
    );

Map<String, dynamic> _$AnimationEntryToJson(AnimationEntry instance) =>
    <String, dynamic>{
      'animation_length': instance.animationLength,
      'loop': instance.loop,
      'timeline': instance.timeline,
    };

ItemElement _$ItemElementFromJson(Map<String, dynamic> json) => ItemElement(
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>?),
      description:
          ItemDescription.fromJson(json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemElementToJson(ItemElement instance) =>
    <String, dynamic>{
      'components': Components.toJson(instance.components),
      'description': instance.description,
    };

ItemDescription _$ItemDescriptionFromJson(Map<String, dynamic> json) =>
    ItemDescription(
      identifier: json['identifier'] as String,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ItemDescriptionToJson(ItemDescription instance) =>
    <String, dynamic>{
      'category': instance.category,
      'identifier': instance.identifier,
    };

LootPoolsElement _$LootPoolsElementFromJson(Map<String, dynamic> json) =>
    LootPoolsElement(
      pools: (json['pools'] as List<dynamic>)
          .map((e) => LootTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LootPoolsElementToJson(LootPoolsElement instance) =>
    <String, dynamic>{
      'pools': instance.pools,
    };

LootTable _$LootTableFromJson(Map<String, dynamic> json) => LootTable(
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) => LootEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      conditions: (json['conditions'] as List<dynamic>?)
          ?.map(
              (e) => const LootConditions().fromJson(e as Map<String, dynamic>))
          .toList(),
      rolls:
          json['rolls'] == null ? null : CountOrRange.fromJson(json['rolls']),
      tiers: json['tiers'] == null
          ? null
          : LootTier.fromJson(json['tiers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LootTableToJson(LootTable instance) => <String, dynamic>{
      'conditions':
          instance.conditions?.map(const LootConditions().toJson).toList(),
      'entries': instance.entries,
      'rolls': instance.rolls,
      'tiers': instance.tiers,
    };

ServerEntityElement _$ServerEntityElementFromJson(Map<String, dynamic> json) =>
    ServerEntityElement(
      componentGroups: (json['component_groups'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>?),
      description: ServerEntityDescription.fromJson(
          json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerEntityElementToJson(
        ServerEntityElement instance) =>
    <String, dynamic>{
      'component_groups': instance.componentGroups,
      'components': Components.toJson(instance.components),
      'description': instance.description,
    };

ServerEntityDescription _$ServerEntityDescriptionFromJson(
        Map<String, dynamic> json) =>
    ServerEntityDescription(
      identifier: json['identifier'] as String,
      animations: (json['animations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      isExperimental: json['is_experimental'] as bool?,
      isSpawnable: json['is_spawnable'] as bool?,
      isSummonable: json['is_summonable'] as bool?,
      scripts: json['scripts'] == null
          ? null
          : ServerEntityScripts.fromJson(
              json['scripts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerEntityDescriptionToJson(
        ServerEntityDescription instance) =>
    <String, dynamic>{
      'animations': instance.animations,
      'identifier': instance.identifier,
      'is_spawnable': instance.isSpawnable,
      'is_summonable': instance.isSummonable,
      'is_experimental': instance.isExperimental,
      'scripts': instance.scripts,
    };

ServerEntityScripts _$ServerEntityScriptsFromJson(Map<String, dynamic> json) =>
    ServerEntityScripts(
      animate:
          (json['animate'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ServerEntityScriptsToJson(
        ServerEntityScripts instance) =>
    <String, dynamic>{
      'animate': instance.animate,
    };

ShapedRecipeElement _$ShapedRecipeElementFromJson(Map<String, dynamic> json) =>
    ShapedRecipeElement(
      description: RecipeDescription.fromJson(
          json['description'] as Map<String, dynamic>),
      key: (json['key'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RecipeIngredient.fromJson(e as Map<String, dynamic>)),
      ),
      pattern:
          (json['pattern'] as List<dynamic>).map((e) => e as String).toList(),
      result: SingleOrList<RecipeResult>.fromJson(
          json['result'], (value) => RecipeResult.fromJson(value)),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      group: json['group'] as String?,
    );

Map<String, dynamic> _$ShapedRecipeElementToJson(
        ShapedRecipeElement instance) =>
    <String, dynamic>{
      'description': instance.description,
      'group': instance.group,
      'key': instance.key,
      'pattern': instance.pattern,
      'result': instance.result,
      'tags': instance.tags,
    };

ShapelessRecipeElement _$ShapelessRecipeElementFromJson(
        Map<String, dynamic> json) =>
    ShapelessRecipeElement(
      description: RecipeDescription.fromJson(
          json['description'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: RecipeResult.fromJson(json['result']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ShapelessRecipeElementToJson(
        ShapelessRecipeElement instance) =>
    <String, dynamic>{
      'description': instance.description,
      'ingredients': instance.ingredients,
      'result': instance.result,
      'tags': instance.tags,
    };

RecipeDescription _$RecipeDescriptionFromJson(Map<String, dynamic> json) =>
    RecipeDescription(
      identifier: json['identifier'] as String,
    );

Map<String, dynamic> _$RecipeDescriptionToJson(RecipeDescription instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
    };

RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) =>
    RecipeIngredient(
      item: json['item'] as String,
      count: json['count'] as int?,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$RecipeIngredientToJson(RecipeIngredient instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
      'item': instance.item,
    };

RecipeResult _$RecipeResultFromJson(Map<String, dynamic> json) => RecipeResult(
      item: json['item'] as String,
      count: json['count'] as int? ?? 1,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$RecipeResultToJson(RecipeResult instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
      'item': instance.item,
    };
