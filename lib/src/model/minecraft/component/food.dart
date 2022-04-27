import 'package:json_annotation/json_annotation.dart';

import '../effect.dart';

part 'food.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftComponentFood {
  final List<MinecraftEffect>? effects;
  final int nutrition;
  final String? onUseAction;
  final SaturationModifier saturationModifier;
  final String? usingConvertsTo;

  MinecraftComponentFood({
    required this.nutrition,
    required this.saturationModifier,
    this.effects,
    this.onUseAction,
    this.usingConvertsTo,
  });

  factory MinecraftComponentFood.fromJson(Map<String, dynamic> json) =>
      _$MinecraftComponentFoodFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftComponentFoodToJson(this);

  @override
  String toString() =>
      'Nutrition: $nutrition, ${saturationModifier.name} saturation' +
      (effects == null ? '' : '\nEffects: ${effects!.join(', ')}');
}

@JsonEnum(fieldRename: FieldRename.snake)
enum SaturationModifier {
  good,
  low,
  normal,
  poor,
  supernatural,
}
