import 'package:json_annotation/json_annotation.dart';

import 'pack_element.dart';

part 'animation_controller.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllers extends PackElement {
  final Map<String, AnimationController> controllers;

  AnimationControllers({required this.controllers});

  factory AnimationControllers.fromJson(dynamic json) =>
      _$AnimationControllersFromJson({"controllers": json});

  Map<String, dynamic> toJson() =>
      _$AnimationControllersToJson(this)['controllers'];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationController {
  final Map<String, AnimationControllerState> states;

  AnimationController({
    required this.states,
  });

  factory AnimationController.fromJson(Map<String, dynamic> json) =>
      _$AnimationControllerFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationControllerToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimationControllerState {
  final List<Map<String, String>> transitions;

  AnimationControllerState({
    required this.transitions,
  });

  factory AnimationControllerState.fromJson(Map<String, dynamic> json) =>
      _$AnimationControllerStateFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationControllerStateToJson(this);
}
