import 'package:json_annotation/json_annotation.dart';

import '../trigger.dart';
import 'component.dart';

part 'interact.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InteractComponent implements Component {
  final List<Interaction> interactions;

  InteractComponent({
    required this.interactions,
  });

  @override
  get parameters => [
        ComponentParam('Interactions', interactions),
      ];

  factory InteractComponent.fromJson(Map<String, dynamic> json) =>
      _$InteractComponentFromJson(json);

  Map<String, dynamic> toJson() => _$InteractComponentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Interaction {
  final int hurtItem;
  final String interactText;
  final Trigger onInteract;
  final String? playSounds;
  final bool swing;
  final bool useItem;

  Interaction({
    required this.hurtItem,
    required this.interactText,
    required this.onInteract,
    this.playSounds,
    this.swing = false,
    this.useItem = false,
  });

  factory Interaction.fromJson(Map<String, dynamic> json) =>
      _$InteractionFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionToJson(this);
}
