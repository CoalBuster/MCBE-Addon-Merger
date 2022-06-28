import 'package:flutter/material.dart';

import '../../model/component.dart';

class InteractTile extends StatelessWidget {
  const InteractTile({
    Key? key,
    required this.interact,
  }) : super(key: key);

  final InteractComponent interact;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Interactable'),
      subtitle: Text('${interact.interactions.length} possible interaction(s)'),
      children: interact.interactions
          .map((e) => ListTile(
                title: Text(e.interactText ?? '<nameless-interaction>'),
                subtitle: Text('Condition: ${e.onInteract.filters}' +
                    (e.onInteract.event == null
                        ? ''
                        : '\nEvent: ${e.onInteract.event} on ${e.onInteract.target ?? 'self'}')),
              ))
          .toList(),
    );
  }
}
