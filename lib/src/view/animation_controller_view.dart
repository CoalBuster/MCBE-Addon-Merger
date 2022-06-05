import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart' as mc;

class AnimationControllerDetailView extends StatelessWidget {
  final Map<String, mc.AnimationController> animationControllers;
  final mc.Version? formatVersion;
  final String? name;

  const AnimationControllerDetailView({
    required this.animationControllers,
    required this.name,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animContr = animationControllers[name];

    if (animContr == null) {
      return Text('Animation Controller $name not found');
    }

    return ListView(
      restorationId: 'animationControllerListView',
      children: [
        ListTile(
          title: Text(name!),
          subtitle: formatVersion == null
              ? null
              : Text('Format Version: $formatVersion'),
        ),
        ExpansionTile(
          title: const Text('States'),
          subtitle: Text('${animContr.states.length} state(s)'),
          children: animContr.states.entries
              .map((e) => ListTile(
                    title: Text(e.key),
                    subtitle: Text(e.value.transitions
                        .map((e) => '-> ${e.keys.single} (${e.values.single})')
                        .join('\n')),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
