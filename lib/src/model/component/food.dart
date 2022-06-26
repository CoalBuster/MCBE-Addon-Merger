import 'package:json_annotation/json_annotation.dart';

import '../effect.dart';
import '../saturation.dart';
import 'component.dart';

part 'food.g.dart';

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
