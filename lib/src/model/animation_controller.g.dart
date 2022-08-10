// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimationControllers _$AnimationControllersFromJson(
        Map<String, dynamic> json) =>
    AnimationControllers(
      controllers: (json['controllers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, AnimationController.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AnimationControllersToJson(
        AnimationControllers instance) =>
    <String, dynamic>{
      'controllers': instance.controllers,
    };

AnimationController _$AnimationControllerFromJson(Map<String, dynamic> json) =>
    AnimationController(
      states: (json['states'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, AnimationControllerState.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AnimationControllerToJson(
        AnimationController instance) =>
    <String, dynamic>{
      'states': instance.states,
    };

AnimationControllerState _$AnimationControllerStateFromJson(
        Map<String, dynamic> json) =>
    AnimationControllerState(
      transitions: (json['transitions'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$AnimationControllerStateToJson(
        AnimationControllerState instance) =>
    <String, dynamic>{
      'transitions': instance.transitions,
    };
