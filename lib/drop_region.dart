import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class CustomDropRegion extends StatefulWidget {
  const CustomDropRegion({
    super.key,
    required this.child,
    required this.onDropEnter,
    required this.onDropLeave,
    required this.onStoreImage,
  });

  final Widget child;
  final VoidCallback onDropEnter;
  final VoidCallback onDropLeave;
  final void Function(Uint8List) onStoreImage;

  @override
  State<CustomDropRegion> createState() => _CustomDropRegionState();
}

class _CustomDropRegionState extends State<CustomDropRegion> {
  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: const <DataFormat<Object>>[
        Formats.jpeg,
        Formats.png,
        Formats.heif,
      ],
      onDropOver: (p0) {
        return DropOperation.copy;
      },
      onPerformDrop: (PerformDropEvent event) async {
        // Getting the dropped data
        final item = event.session.items.first;

        // Getting the data reader
        final reader = item.dataReader!;

        if (reader.canProvide(Formats.png)) {
          reader.getFile(
            Formats.png,
            (file) async {
              final Uint8List data = await file.readAll();
              widget.onStoreImage(data);
            },
            onError: (error) {
              print('Error reading value $error');
            },
          );
        } else {}
      },
      onDropEnter: (_) {
        widget.onDropEnter();
      },
      onDropLeave: (_) {
        widget.onDropLeave();
      },
      child: widget.child,
    );
  }
}
