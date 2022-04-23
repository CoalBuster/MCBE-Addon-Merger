import 'package:flutter/material.dart';

import '../model/minecraft/animation_controller.dart';
import '../model/version.dart';

class AnimationControllerDetailView extends StatelessWidget {
  final MinecraftAnimationController animationController;
  final Version? formatVersion;
  final String name;

  const AnimationControllerDetailView({
    required this.animationController,
    required this.name,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(name),
          subtitle:
              formatVersion == null ? null : Text('Format: v$formatVersion'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: animationController.states.length,
            itemBuilder: (context, index) {
              final state = animationController.states.entries.elementAt(index);

              return ListTile(
                title: Text(state.key),
                subtitle: Text(state.value.transitions
                    .map((e) => '-> ${e.keys.single} (${e.values.single})')
                    .join('\n')),
              );
            },
          ),
        ),
      ],
    );
  }
}
