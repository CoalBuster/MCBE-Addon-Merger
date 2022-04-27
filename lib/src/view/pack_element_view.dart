import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/pack_element_type.dart';
import 'animation_controller_view.dart';
import 'entity_view.dart';
import 'item_view.dart';

class PackElementDetailView extends StatelessWidget {
  final PackElement? element;
  final String? name;

  const PackElementDetailView({
    required this.element,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (element == null) {
      return const Center(
        child: Text('No element'),
      );
    }

    switch (element!.type) {
      case PackElementType.animationController:
        if (name == null) {
          return const Text('Animation Controller no name');
        }

        return AnimationControllerDetailView(
          animationControllers: element!.animationControllers!,
          formatVersion: element!.formatVersion,
          name: name!,
        );
      case PackElementType.entity:
        return EntityDetailView(
          entity: element!.entity!,
          formatVersion: element!.formatVersion,
        );
      case PackElementType.item:
        return ItemDetailView(
          item: element!.item!,
          formatVersion: element!.formatVersion,
        );
      default:
        return Center(
          child: Text('Unhandled type: ${element!.type?.name}'),
        );
    }
  }
}
