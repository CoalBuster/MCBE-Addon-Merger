import 'package:json_annotation/json_annotation.dart';

import '../range.dart';
import 'function.dart';

part 'damage.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionDamage extends LootFunction {
  final DoubleRange damage;

  LootFunctionDamage({
    required super.function,
    required this.damage,
  });

  factory LootFunctionDamage.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionDamageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionDamageToJson(this);

  @override
  String toString() => 'Damaged (${damage.min * 100}% - ${damage.max * 100}%)';
}
