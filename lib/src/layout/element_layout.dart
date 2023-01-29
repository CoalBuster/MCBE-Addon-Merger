import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

import '../controller/element_controller.dart';
import '../util/json_pointer_ext.dart';
import '../view/parameters_view.dart';

class ElementLayout extends StatefulWidget {
  static const routeName = '/pack/element';

  final PackElementController elementController;

  const ElementLayout({
    required this.elementController,
    Key? key,
  }) : super(key: key);

  @override
  State<ElementLayout> createState() => _ElementLayoutState();
}

class _ElementLayoutState extends State<ElementLayout> {
  var path = JsonPointer.fromString('');
  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 850;
        pageController = PageController(
          viewportFraction: mobile ? 1 : 1 / 3,
          initialPage: path.isRoot ? 0 : path.segments.length - 1,
        );

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.elementController.displayName ?? 'Element Detail'),
                Text(
                  widget.elementController.category!.asString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            leading: mobile && path.hasParent
                ? BackButton(
                    onPressed: () => setState(() => path = path.parent),
                  )
                : null,
          ),
          body: mobile
              ? ParametersView(
                  object: widget.elementController.element,
                  path: path,
                  onItemSelected: (p) => setState(() => path = p),
                )
              : PageView(
                  controller: pageController,
                  children: List.generate(
                    path.segments.length + 1,
                    (index) => ParametersView(
                      object: widget.elementController.element,
                      path: path.up(index),
                      onItemSelected: (p) => setState(() {
                        path = p;
                        pageController.animateToPage(
                            path.isRoot ? 0 : path.segments.length - 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease);
                      }),
                      selected: index == 0 ? null : path.up(index - 1),
                    ),
                  ).reversed.toList(),
                ),
        );
      },
    );
  }
}
