import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/addon_controller.dart';
import '../model/manifest.dart';

class PackView extends StatefulWidget {
  final AddonController addonController;
  final Function()? onTap;
  final Manifest pack;

  const PackView({
    required this.addonController,
    required this.pack,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<PackView> createState() => _PackViewState();
}

class _PackViewState extends State<PackView> {
  late Future<Uint8List?> _iconFuture;

  @override
  void initState() {
    super.initState();
    _iconFuture =
        widget.addonController.getPackIconAsync(widget.pack.header.uuid);
  }

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.roboto();

    return ListTile(
      title: Text(widget.pack.header.name, style: style),
      leading: FutureBuilder<Uint8List?>(
        future: _iconFuture,
        builder: (context, snapshot) => snapshot.hasData
            ? Image.memory(snapshot.data!)
            : const CircleAvatar(),
      ),
      selected: widget.addonController.isSelected(widget.pack.header.uuid),
      subtitle: Text(
        widget.pack.header.description,
        style: style,
        maxLines: 3,
      ),
      isThreeLine: true,
      onTap: () {
        if (widget.addonController.multiSelectMode) {
          widget.addonController.isSelected(widget.pack.header.uuid)
              ? widget.addonController.unselect(widget.pack.header.uuid)
              : widget.addonController.select(widget.pack.header.uuid);
        } else {
          widget.addonController.select(widget.pack.header.uuid);
          widget.onTap?.call();
        }
      },
      onLongPress: () {
        widget.addonController.select(widget.pack.header.uuid, true);
      },
    );
  }
}
