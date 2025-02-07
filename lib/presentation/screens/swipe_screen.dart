import 'package:flutter/material.dart';
import 'package:stickers_drop_app/presentation/widgets/animated_sticker_transform.dart';
import 'package:stickers_drop_app/data/image_source.dart';
import 'package:stickers_drop_app/presentation/widgets/image_with_border_and_shadow.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key, required this.topImage});

  final ImageProvider topImage;

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  void _onHorizontalDragEnd(details) {
    double velocity = details.primaryVelocity ?? 0.0;

    if (velocity > 300) {
      if (_selectedIndex.value > 0) {
        _selectedIndex.value--;
      }
    } else if (velocity < -300) {
      if (_selectedIndex.value < ImageSource.asset.length) {
        _selectedIndex.value++;
      }
    }
  }

  Duration get _duration => const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 242, 223),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            GestureDetector(
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  for (final (index, asset)
                      in ImageSource.asset.reversed.indexed)
                    ValueListenableBuilder<int>(
                      valueListenable: _selectedIndex,
                      builder: (context, selectedIndex, _) {
                        final newIndex = ImageSource.asset.length - index;
                        final isSelected = newIndex < selectedIndex;

                        final double scale = isSelected
                            ? 1
                            : 1 - ((newIndex - selectedIndex) * 0.02);

                        final double rotation =
                            newIndex == selectedIndex ? 0 : 0.2;

                        final offset = isSelected
                            ? const Offset(-350, 0)
                            : Offset(
                                ((newIndex - selectedIndex) * 10),
                                ((newIndex - selectedIndex) * -5),
                              );

                        return AnimatedStickerTransform(
                          duration: _duration,
                          curve: Curves.easeInOut,
                          scale: scale,
                          offset: offset,
                          rotation: rotation,
                          child: SizedBox(
                            width: 200,
                            child: ImageWithBorderAndShadow(image: asset),
                          ),
                        );
                      },
                    ),
                  ValueListenableBuilder<int>(
                    valueListenable: _selectedIndex,
                    builder: (context, selectedIndex, _) {
                      final offset = selectedIndex > 0
                          ? const Offset(-350, 0)
                          : const Offset(0, 0);

                      return AnimatedStickerTransform(
                        duration: _duration,
                        curve: Curves.easeInOut,
                        scale: 1,
                        rotation: 0,
                        offset: offset,
                        child: SizedBox(
                          width: 200,
                          child: ImageWithBorderAndShadow(
                              imageProvider: widget.topImage),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 40),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.share, size: 40)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete, size: 40)),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
