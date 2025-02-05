import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stickers_drop_app/image_source.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    return DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      dashPattern: const [10, 10],
                      color: Colors.black.withOpacity(0.2),
                      strokeWidth: 2,
                      child: Center(
                        child: index != 0
                            ? Image.asset(
                                ImageSource.asset[index - 1],
                              )
                            : const Text(
                                'DRAG AMD DROP YOUR STICKER',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
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
