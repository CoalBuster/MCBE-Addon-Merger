// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftAnimationController _$MinecraftAnimationControllerFromJson(
        Map<String, dynamic> json) =>
    MinecraftAnimationController(
      states: (json['states'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            MinecraftAnimationControllerState.fromJson(
                e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$MinecraftAnimationControllerToJson(
        MinecraftAnimationController instance) =>
    <String, dynamic>{
      'states': instance.states,
    };

MinecraftAnimationControllerState _$MinecraftAnimationControllerStateFromJson(
        Map<String, dynamic> json) =>
    MinecraftAnimationControllerState(
      transitions: (json['transitions'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$MinecraftAnimationControllerStateToJson(
        MinecraftAnimationControllerState instance) =>
    <String, dynamic>{
      'transitions': instance.transitions,
    };
