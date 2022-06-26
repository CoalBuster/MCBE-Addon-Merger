import 'package:json_annotation/json_annotation.dart';
import 'package:numerus/numerus.dart';

part 'effect.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Effect {
  final int amplifier;
  final double? chance;
  final int duration;
  final String name;

  Effect({
    required this.amplifier,
    required this.chance,
    required this.duration,
    required this.name,
  });

  factory Effect.fromJson(Map<String, dynamic> json) => _$EffectFromJson(json);

  Map<String, dynamic> toJson() => _$EffectToJson(this);

  @override
  String toString() =>
      '$name ${amplifier <= 0 ? '' : '(${amplifier.toRomanNumeralString()}) '}for $duration seconds${chance == null ? '' : ' (${chance! * 100}%)'}';
}
