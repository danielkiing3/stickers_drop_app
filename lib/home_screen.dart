import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stickers_drop_app/drop_region.dart';
import 'package:stickers_drop_app/image_source.dart';
import 'package:stickers_drop_app/swipe_screen.dart';
import 'package:stickers_drop_app/utils/cached_image_provider.dart';
import 'package:stickers_drop_app/widgets/image_with_border_and_shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? hoverIndex;
  CacheMemoryImageProvider? dropImage;

  void updateHoverIndex(int index) {
    setState(() {
      hoverIndex = index;
    });
  }

  void resetHoverIndex() {
    setState(() {
      hoverIndex = null;
    });
  }

  void storeImage(Uint8List file) {
    final value = CacheMemoryImageProvider(
      'app://dropImage${DateTime.now()}',
      file,
    );

    dropImage = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 242, 223),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  Text(
                    'Nov.',
                    style: TextStyle(
                        color: Color.fromARGB(255, 47, 24, 243), fontSize: 80),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '-4 DAYS BEFORE NOVEMBER STICKER BOX SHIPS.',
                          maxLines: 2,
                        ),
                        Text(
                          '1 STICKER BOX SHIPS.',
                          maxLines: 2,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: GridView.builder(
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
                        color: hoverIndex == index
                            ? Colors.blue
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
                              : dropImage != null
                                  ? GestureDetector(
                                      onTap: dropImage != null
                                          ? () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return SwipeScreen(
                                                    topImage: dropImage!,
                                                  );
                                                },
                                              ));
                                            }
                                          : null,
                                      child: Transform.scale(
                                        scale: 0.8,
                                        child: ImageWithBorderAndShadow(
                                          imageProvider: dropImage,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'DRAG AMD DROP YOUR STICKER',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '? HOW TO USE',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
