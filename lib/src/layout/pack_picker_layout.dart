import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger/src/controller/addon_controller.dart';

import '../model/pack.dart';
import '../view/pack_list_view.dart';

class PackPickerLayout extends StatefulWidget {
  static const routeName = '/pack-picker';

  final AddonController addonController;
  final int packCount;

  const PackPickerLayout({
    required this.addonController,
    this.packCount = 1,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PackPickerLayout();
}

class _PackPickerLayout extends State<PackPickerLayout> {
  final List<Pack> _packs = [];

  @override
  void initState() {
    super.initState();

    widget.addonController.loadAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Packs'),
      ),
      body: AnimatedBuilder(
        animation: widget.addonController,
        builder: (context, child) {
          if (widget.addonController.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PackListView(
                  onPackTapped: (pack) => setState(() {
                    if (_packs.contains(pack)) {
                      _packs.remove(pack);
                    } else {
                      _packs.add(pack);
                    }
                  }),
                  packs: widget.addonController.packs,
                  selected: _packs,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  child: const Text('Pick Folder'),
                  onPressed: () => widget.addonController.loadAsync(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  child: const Text('Select'),
                  onPressed: _packs.length == widget.packCount
                      ? () => _onPacksSelected(context, _packs)
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onPacksSelected(BuildContext context, List<Pack> packs) {
    Navigator.pop(context, packs);
  }
}
