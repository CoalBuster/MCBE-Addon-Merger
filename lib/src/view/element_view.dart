import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger/src/view/recipe_view.dart';

import '../controller/element_controller.dart';
import '../model/pack_element.dart';
import 'animation_controller_view.dart';
import 'animation_view.dart';
import 'entity_view.dart';
import 'item_view.dart';
import 'loot_table_view.dart';

class ElementView extends StatelessWidget {
  final PackElementController elementController;

  const ElementView({
    required this.elementController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: AnimatedBuilder(
        animation: elementController,
        builder: (context, child) {
          if (elementController.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (elementController.path == null) {
            return const Center(
              child: Text('No element selected'),
            );
          }

          if (elementController.element == null) {
            return Center(
              child: Text('Element not found: ${elementController.path}'),
            );
          }

          switch (elementController.type) {
            case PackElementType.animationControllers:
              return AnimationControllerDetailView(
                animationControllers:
                    elementController.element as AnimationControllersElement,
                formatVersion: elementController.formatVersion,
                name: elementController.name,
              );
            case PackElementType.animations:
              return AnimationDetailView(
                animations: elementController.element as AnimationsElement,
                formatVersion: elementController.formatVersion,
                name: elementController.name,
              );
            case PackElementType.entity:
              return EntityDetailView(
                entity: elementController.element as ServerEntityElement,
                formatVersion: elementController.formatVersion,
                patches: elementController.patches,
              );
            case PackElementType.item:
              return ItemDetailView(
                item: elementController.element as ItemElement,
                formatVersion: elementController.formatVersion,
              );
            case PackElementType.lootTable:
              return LootTableDetailView(
                lootTables: elementController.element as LootPoolsElement,
                formatVersion: elementController.formatVersion,
              );
            case PackElementType.recipeShaped:
              return ShapedRecipeDetailView(
                recipe: elementController.element as ShapedRecipeElement,
                formatVersion: elementController.formatVersion,
              );
            case PackElementType.recipeShapeless:
              return ShapelessRecipeDetailView(
                recipe: elementController.element as ShapelessRecipeElement,
                formatVersion: elementController.formatVersion,
              );
            default:
              return Center(
                child: Text('Unhandled type: ${elementController.type}'),
              );
          }
        },
      ),
    );
  }
}
