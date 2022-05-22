import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

import '../../model/patch.dart';

class PatchedTile extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final dynamic value;
  final List<Patch>? patches;

  const PatchedTile({
    required this.title,
    Key? key,
    this.patches,
    this.subtitle,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: patches == null
          ? null
          : PatchEffectView(
              original: value,
              patches: patches!,
            ),
      title: Text(title),
      subtitle: subtitle ??
          PatchedText(
            original: value,
            patches: patches,
          ),
    );
  }
}

class PatchedText extends StatelessWidget {
  final dynamic original;
  final List<Patch>? patches;

  const PatchedText({
    required this.original,
    required this.patches,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (patches == null || patches!.isEmpty) {
      return Text('$original');
    }

    if (patches!.length == 1) {
      final patch = patches!.first;

      if (patch.operation == PatchOperation.remove ||
          (patch.operation == PatchOperation.replace && patch.value == null)) {
        return Tooltip(
          message: 'Was: $original',
          child: const Text(
            'REMOVED',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }

      return Tooltip(
        message: 'Was: $original',
        child: Text(
          '${patch.value}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    final value =
        JsonPatch.apply(original, patches!.map((e) => e.toJson()).toList());
    return Tooltip(
      message: 'Was: $original',
      child: Text(
        '$value',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PatchEffectView extends StatelessWidget {
  final dynamic original;
  final List<Patch> patches;

  const PatchEffectView({
    required this.original,
    required this.patches,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (patches.isEmpty) {
      return Icon(Icons.remove, color: Theme.of(context).colorScheme.secondary);
    }

    if (patches.length == 1) {
      final patch = patches.first;

      if (patch.operation == PatchOperation.remove ||
          (patch.operation == PatchOperation.replace && patch.value == null)) {
        return const Icon(Icons.remove_circle, color: Colors.red);
      }

      if (patch.operation == PatchOperation.add ||
          (patch.operation == PatchOperation.replace && original == null)) {
        return const Icon(Icons.add_circle, color: Colors.green);
      }

      if (patch.operation == PatchOperation.replace) {
        return const Icon(Icons.swap_horiz, color: Colors.orange);
      }

      return const Icon(Icons.question_mark);
    }

    return const Icon(Icons.swap_horiz, color: Colors.orange);
  }
}
