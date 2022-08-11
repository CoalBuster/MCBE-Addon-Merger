import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/version.dart';

class AnimationDetailView extends StatelessWidget {
  final AnimationsElement animations;
  final Version? formatVersion;
  final String? name;

  const AnimationDetailView({
    required this.animations,
    required this.name,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final anim = animations.animations[name];

    if (anim == null) {
      return Center(
        child: Text('Animation $name not found'),
      );
    }

    return ListView(
      restorationId: 'animationDetailListView',
      children: [
        ListTile(
          title: const Text('Animation'),
          subtitle: formatVersion == null
              ? null
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Format Version: $formatVersion'),
                    Text('Length: ${anim.animationLength}'),
                  ],
                ),
        ),
        SwitchListTile(
          title: const Text('Loop'),
          value: anim.loop,
          onChanged: (v) {},
        ),
        ExpansionTile(
          title: const Text('Timeline'),
          subtitle: Text('${anim.timeline.length} stop(s)'),
          children: anim.timeline.entries
              .map((e) => ListTile(
                    title: Text(e.key),
                    subtitle: Text(e.value.items.join('\n')),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
