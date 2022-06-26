import 'package:json_annotation/json_annotation.dart';

import 'function.dart';

part 'data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootFunctionData extends LootFunction {
  final int data;

  LootFunctionData({
    required String function,
    required this.data,
  }) : super(function: function);

  factory LootFunctionData.fromJson(Map<String, dynamic> json) =>
      _$LootFunctionDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootFunctionDataToJson(this);

  @override
  String toString() => 'Data: $data';
}
