import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';

class InteractTile extends StatelessWidget {
  const InteractTile({
    Key? key,
    required this.interact,
  }) : super(key: key);

  final EntityComponentInteract interact;

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
