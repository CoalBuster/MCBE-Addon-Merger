import 'package:json_annotation/json_annotation.dart';

import '../range.dart';
import 'function.dart';

part 'looting.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionLooting extends LootFunction {
  final IntegerRange count;

  LootFunctionLooting({
    required String function,
    required this.count,
  }) : super(function: function);

  factory LootFunctionLooting.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionLootingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionLootingToJson(this);

  @override
  String toString() => 'Looting: +${count.min}-${count.max} per lvl';
}
