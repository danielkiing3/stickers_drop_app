import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stickers_drop_app/data/image_source.dart';
import 'package:stickers_drop_app/presentation/screens/swipe_screen.dart';
import 'package:stickers_drop_app/presentation/widgets/drop_region.dart';
import 'package:stickers_drop_app/presentation/widgets/image_with_border_and_shadow.dart';
import 'package:stickers_drop_app/utils/cached_image_provider.dart';

class HomeGridContent extends StatefulWidget {
  const HomeGridContent({super.key});

  @override
  State<HomeGridContent> createState() => _HomeGridContentState();
}

class _HomeGridContentState extends State<HomeGridContent> {
  final ValueNotifier<int?> hoverIndex = ValueNotifier<int?>(null);
  final ValueNotifier<CacheMemoryImageProvider?> dropImage =
      ValueNotifier<CacheMemoryImageProvider?>(null);

  void updateHoverIndex(int index) {
    hoverIndex.value = index;
  }

  void resetHoverIndex() {
    hoverIndex.value = null;
  }

  void storeImage(Uint8List file) {
    dropImage.value = CacheMemoryImageProvider(
      'app://dropImage${DateTime.now()}',
      file,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: hoverIndex,
      builder: (context, hover, _) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            crossAxisCount: 3,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (context, index) {
            return CustomDropRegion(
              onDropEnter: () => updateHoverIndex(index),
              onDropLeave: resetHoverIndex,
              onStoreImage: storeImage,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [10, 10],
                color: hover == index
                    ? const Color.fromARGB(255, 47, 24, 243)
                    : Colors.black.withOpacity(0.2),
                strokeWidth: 2,
                child: Center(
                  child: index != 0
                      ? Transform.scale(
                          scale: 0.8,
                          child: ImageWithBorderAndShadow(
                            image: ImageSource.asset[index - 1],
                          ),
                        )
                      : ValueListenableBuilder<CacheMemoryImageProvider?>(
                          valueListenable: dropImage,
                          builder: (context, image, _) {
                            return image != null
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => SwipeScreen(
                                          topImage: image,
                                        ),
                                      ));
                                    },
                                    child: ImageWithBorderAndShadow(
                                      imageProvider: image,
                                    ),
                                  )
                                : const Text(
                                    'DRAG AND DROP YOUR STICKER',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  );
                          },
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
