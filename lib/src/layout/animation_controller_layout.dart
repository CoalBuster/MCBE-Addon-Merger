import 'package:flutter/material.dart';

import '../model/minecraft/animation_controller.dart';
import '../model/version.dart';
import '../view/animation_controller_view.dart';

class AnimationControllerLayout extends StatelessWidget {
  static const routeName = '/pack/animation-controller';

  final MinecraftAnimationController animationController;
  final Version? formatVersion;
  final String name;

  const AnimationControllerLayout({
    required this.animationController,
    required this.name,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Controller'),
      ),
      body: AnimationControllerDetailView(
        animationController: animationController,
        formatVersion: formatVersion,
        name: name,
      ),
    );
  }
}
