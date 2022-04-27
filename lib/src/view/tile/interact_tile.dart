import 'package:flutter/material.dart';

import '../../model/minecraft/component/interact.dart';

class InteractTile extends StatelessWidget {
  const InteractTile({
    Key? key,
    required this.interact,
  }) : super(key: key);

  final MinecraftComponentInteract interact;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Interactable'),
      subtitle: Text('${interact.interactions.length} possible interaction(s)'),
      children: interact.interactions
          .map((e) => ListTile(
                title: Text(e.interactText),
                subtitle: Text('Condition: ${e.onInteract.filters}'),
              ))
          .toList(),
    );
  }
}
