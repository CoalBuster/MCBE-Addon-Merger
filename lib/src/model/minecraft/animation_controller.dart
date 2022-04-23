import 'package:json_annotation/json_annotation.dart';

part 'animation_controller.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftAnimationController {
  final Map<String, MinecraftAnimationControllerState> states;

  MinecraftAnimationController({
    required this.states,
  });

  factory MinecraftAnimationController.fromJson(Map<String, dynamic> json) =>
      _$MinecraftAnimationControllerFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftAnimationControllerToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftAnimationControllerState {
  final List<Map<String, String>> transitions;

  MinecraftAnimationControllerState({
    required this.transitions,
  });

  factory MinecraftAnimationControllerState.fromJson(
          Map<String, dynamic> json) =>
      _$MinecraftAnimationControllerStateFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MinecraftAnimationControllerStateToJson(this);
}
