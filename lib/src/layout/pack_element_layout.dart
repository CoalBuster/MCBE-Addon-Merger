import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/pack_element_type.dart';
import '../view/pack_element_view.dart';

class PackElementLayout extends StatelessWidget {
  static const routeName = '/pack/element';

  final PackElement? element;
  final String? path;
  final String? name;

  const PackElementLayout({
    required this.element,
    required this.path,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_typeString(element?.type) ?? 'Pack Element Details'),
            if (path != null)
              Text(
                path!,
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ),
      ),
      body: PackElementDetailView(
        element: element,
        name: name,
      ),
    );
  }

  static String? _typeString(PackElementType? type) {
    switch (type) {
      case PackElementType.animationController:
        return 'Animation Controller';
      case PackElementType.entity:
        return 'Entity';
      default:
        return null;
    }
  }
}
