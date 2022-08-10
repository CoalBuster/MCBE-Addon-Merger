import 'package:flutter/material.dart';
import '../model/animation_controller.dart' as mc;
import '../model/version.dart';

class AnimationControllerDetailView extends StatelessWidget {
  final mc.AnimationControllers animationControllers;
  final Version? formatVersion;
  final String? name;

  const AnimationControllerDetailView({
    required this.animationControllers,
    required this.name,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animContr = animationControllers.controllers[name];

    if (animContr == null) {
      return Center(
        child: Text('Animation Controller $name not found'),
      );
    }

    return ListView(
      restorationId: 'animationControllerListView',
      children: [
        ListTile(
          title: formatVersion == null
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
