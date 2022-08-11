import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/version.dart';

class ShapedRecipeDetailView extends StatelessWidget {
  final Version? formatVersion;
  final ShapedRecipeElement recipe;

  const ShapedRecipeDetailView({
    required this.recipe,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'shapedRecipeDetailListView',
      children: [
        ListTile(
          title: const Text('Shaped Recipe'),
          subtitle: formatVersion == null
              ? null
              : Text('Format Version: $formatVersion'),
        ),
        ListTile(
          title: const Text('Result'),
          subtitle: Text(recipe.result.items.join(', ')),
        ),
      ],
    );
  }
}

class ShapelessRecipeDetailView extends StatelessWidget {
  final Version? formatVersion;
  final ShapelessRecipeElement recipe;

  const ShapelessRecipeDetailView({
    required this.recipe,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'shapelessRecipeDetailListView',
      children: [
        ListTile(
          title: const Text('Shapeless Recipe'),
          subtitle: formatVersion == null
              ? null
              : Text('Format Version: $formatVersion'),
        ),
        ListTile(
          title: const Text('Result'),
          subtitle: Text(recipe.result.toString()),
        ),
      ],
    );
  }
}
