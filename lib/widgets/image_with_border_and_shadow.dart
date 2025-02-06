import 'dart:ui';

import 'package:flutter/material.dart';

class ImageWithBorderAndShadow extends StatelessWidget {
  const ImageWithBorderAndShadow(
      {super.key,
      required this.image,
      this.borderColor = Colors.white,
      this.shadowColor = Colors.black,
      this.borderWidth = 5.0,
      this.shadowRadius = 15.0});

  final String image;
  final Color borderColor;
  final Color shadowColor;
  final double borderWidth;
  final double shadowRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // --  Shadow
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: shadowRadius,
            sigmaY: shadowRadius,
            tileMode: TileMode.decal,
          ),
          child: Opacity(
            opacity: 0.6,
            child: Image.asset(
              image,
              color: shadowColor,
            ),
          ),
        ),

        // -- Background
        ImageFiltered(
          imageFilter: ImageFilter.dilate(
            radiusX: borderWidth,
            radiusY: borderWidth,
          ),
          child: Image.asset(
            image,
            color: borderColor,
          ),
        ),

        // -- Actual Image
        Image.asset(
          image,
        ),
      ],
    );
  }
}
