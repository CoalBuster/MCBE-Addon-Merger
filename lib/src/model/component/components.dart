import 'component.dart';
import 'food.dart';
import 'interact.dart';
import 'seed.dart';
import 'unknown.dart';

class Components {
  static const _components = {
    'minecraft:food': FoodComponent.fromJson,
    'minecraft:interact': InteractComponent.fromJson,
    'minecraft:seed': SeedComponent.fromJson,
  };

  static Map<String, Component> fromJson(Map<String, dynamic> json) {
    return Map.fromEntries(json.entries.map((e) => MapEntry(
          e.key,
          _components[e.key]?.call(e.value) ??
              UnknownComponent.fromJson(e.value),
        )));
  }

  static Map<String, dynamic>? toJson(Map<String, Component> components) {
    return Map.fromEntries(components.entries.map((e) => MapEntry(
          e.key,
          e.value.toJson(),
        )));
  }
}
