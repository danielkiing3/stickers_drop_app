import 'dart:ui';

import 'package:flutter/material.dart';

class ImageWithBorderAndShadow extends StatelessWidget {
  const ImageWithBorderAndShadow({
    super.key,
    this.image,
    this.imageProvider,
    this.borderColor = Colors.white,
    this.shadowColor = Colors.black,
    this.borderWidth = 5.0,
    this.shadowRadius = 15.0,
  }) : assert(image != null || imageProvider != null,
            'Either image or imageProvider must be provided');

  final String? image;
  final ImageProvider? imageProvider;
  final Color borderColor;
  final Color shadowColor;
  final double borderWidth;
  final double shadowRadius;

  @override
  Widget build(BuildContext context) {
    final ImageProvider effectiveImageProvider =
        imageProvider ?? AssetImage(image!);

    Widget child = Image(image: effectiveImageProvider);

    return Stack(
      children: [
        // --  Shadow
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: shadowRadius,
            sigmaY: shadowRadius,
            tileMode: TileMode.decal,
          ),
          child: Opacity(opacity: 0.6, child: child),
        ),

        // -- Background
        ImageFiltered(
          imageFilter: ImageFilter.dilate(
            radiusX: borderWidth,
            radiusY: borderWidth,
          ),
          child: Image(
            image: effectiveImageProvider,
            color: borderColor,
          ),
        ),

        // -- Actual Image
        child
      ],
    );
  }
}
