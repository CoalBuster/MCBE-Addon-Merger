import 'package:json_annotation/json_annotation.dart';

import '../range.dart';
import 'function.dart';

part 'random_aux.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionRandomAux extends LootFunction {
  final IntegerRange values;

  LootFunctionRandomAux({
    required String function,
    required this.values,
  }) : super(function: function);

  factory LootFunctionRandomAux.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionRandomAuxFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionRandomAuxToJson(this);

  @override
  String toString() => 'Random aux: ${values.min} - ${values.max}';
}
