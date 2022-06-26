import 'package:json_annotation/json_annotation.dart';

import 'function.dart';

part 'exploration.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionExploration extends LootFunction {
  final String destination;

  LootFunctionExploration({
    required String function,
    required this.destination,
  }) : super(function: function);

  factory LootFunctionExploration.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionExplorationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionExplorationToJson(this);

  @override
  String toString() => 'Exploration to: $destination';
}
