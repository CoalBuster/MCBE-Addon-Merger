import 'package:json_annotation/json_annotation.dart';
import 'package:numerus/numerus.dart';

part 'effect.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftEffect {
  final int amplifier;
  final double? chance;
  final int duration;
  final String name;

  MinecraftEffect({
    required this.amplifier,
    required this.chance,
    required this.duration,
    required this.name,
  });

  factory MinecraftEffect.fromJson(Map<String, dynamic> json) =>
      _$MinecraftEffectFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftEffectToJson(this);

  @override
  String toString() =>
      '$name ${amplifier <= 0 ? '' : '(${amplifier.toRomanNumeralString()}) '}for $duration seconds${chance == null ? '' : ' (${chance! * 100}%)'}';
}
