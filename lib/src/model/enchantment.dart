import 'package:json_annotation/json_annotation.dart';
import 'package:numerus/numerus.dart';

part 'enchantment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Enchantment {
  final String id;
  final List<int> level;

  Enchantment({
    required this.id,
    required this.level,
  });

  factory Enchantment.fromJson(Map<String, dynamic> json) =>
      _$EnchantmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnchantmentToJson(this);

  @override
  String toString() =>
      '$id (${level.map((e) => e.toRomanNumeralString()).join(' - ')})';
}
