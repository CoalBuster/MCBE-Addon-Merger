// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enchantment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enchantment _$EnchantmentFromJson(Map<String, dynamic> json) => Enchantment(
      id: json['id'] as String,
      level: (json['level'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$EnchantmentToJson(Enchantment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
    };
