import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import 'package:mcbe_addon_merger/src/util/pluralizer.dart';

import '../controller/element_controller.dart';
import '../model/pack_element.dart';
import '../model/parameter.dart';
import '../model/range.dart';
import '../view/components_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 850;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.elementController.name ?? 'Element Detail'),
                Text(
                  widget.elementController.type!.asString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          // drawer: mobile
          //     ? Drawer(
          //         child: _EDL(
          //           elementController: widget.elementController,
          //         ),
          //       )
          //     : null,
          body: Row(
            children: [
              Expanded(
                child: ParametersView(
                  object: widget.elementController.element,
                  name: widget.elementController.name,
                  // parameters: widget.elementController.element!
                  //     .parameters(widget.elementController.name),
                ),
              ),
              // Expanded(
              //   child: _ElementDetailView(
              //     element: widget.elementController.element,
              //     name: widget.elementController.name,
              //   ),
              // ),
              // SizedBox(
              //   width: 300,
              //   child: _EDL(
              //     elementController: widget.elementController,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

class _EDL extends StatelessWidget {
  final PackElementController elementController;

  _EDL({
    required this.elementController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ComponentsView(
            components: (elementController.element as ServerEntityElement?)
                    ?.components ??
                {})
      ],
    );
  }
}
