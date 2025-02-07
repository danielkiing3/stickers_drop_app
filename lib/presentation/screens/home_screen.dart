import 'package:flutter/material.dart';
import 'package:stickers_drop_app/presentation/widgets/home_grid_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 242, 223),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // -- Header
              Row(
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

              // -- Grid Content
              Flexible(child: HomeGridContent()),

              // -- Bottom Section
              SizedBox(height: 24),
              Text(
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
