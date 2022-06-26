import 'package:json_annotation/json_annotation.dart';

import 'function.dart';

part 'unknown.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionUnknown extends LootFunction {
  LootFunctionUnknown({required String function}) : super(function: function);

  factory LootFunctionUnknown.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionUnknownFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionUnknownToJson(this);

  @override
  String toString() => '<$function>';
}
