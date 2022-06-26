import 'package:json_annotation/json_annotation.dart';

import '../enchantment.dart';
import 'function.dart';

part 'enchant.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionEnchant extends LootFunction {
  final List<Enchantment> enchants;

  LootFunctionEnchant({
    required String function,
    required this.enchants,
  }) : super(function: function);

  factory LootFunctionEnchant.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionEnchantFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionEnchantToJson(this);

  @override
  String toString() =>
      'Enchanted with: ${enchants.map((e) => e.toString()).join(', ')}';
}
