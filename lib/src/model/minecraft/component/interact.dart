import 'package:json_annotation/json_annotation.dart';

import '../trigger.dart';

part 'interact.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftComponentInteract {
  final List<MinecraftInteraction> interactions;

  MinecraftComponentInteract({
    required this.interactions,
  });

  factory MinecraftComponentInteract.fromJson(Map<String, dynamic> json) =>
      _$MinecraftComponentInteractFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftComponentInteractToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftInteraction {
  final int hurtItem;
  final String interactText;
  final MinecraftTrigger onInteract;
  final String? playSounds;
  final bool swing;
  final bool useItem;

  MinecraftInteraction({
    required this.hurtItem,
    required this.interactText,
    required this.onInteract,
    this.playSounds,
    this.swing = false,
    this.useItem = false,
  });

  factory MinecraftInteraction.fromJson(Map<String, dynamic> json) =>
      _$MinecraftInteractionFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftInteractionToJson(this);
}
