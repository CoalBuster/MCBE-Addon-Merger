// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_aux.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootFunctionRandomAux _$LootFunctionRandomAuxFromJson(
        Map<String, dynamic> json) =>
    LootFunctionRandomAux(
      function: json['function'] as String,
      values: IntegerRange.fromJson(json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LootFunctionRandomAuxToJson(
        LootFunctionRandomAux instance) =>
    <String, dynamic>{
      'function': instance.function,
      'values': instance.values,
    };
