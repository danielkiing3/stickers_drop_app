import 'package:flutter/material.dart';

class AnimatedStickerTransform extends ImplicitlyAnimatedWidget {
  const AnimatedStickerTransform({
    super.key,
    required super.duration,
    super.curve,
    required this.scale,
    required this.offset,
    required this.rotation,
    required this.child,
    required this.maxOffset,
  });

  final double scale;
  final Offset offset;
  final double rotation;
  final Widget child;
  final double maxOffset;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedStickerTransform> createState() =>
      _AnimatedStickerTransformState();
}

class _AnimatedStickerTransformState
    extends ImplicitlyAnimatedWidgetState<AnimatedStickerTransform> {
  Tween<double>? _scale;
  late Animation<double> _scaleAnimation;

  Tween<Offset>? _offset;
  late Animation<Offset> _offsetAnimation;

  Tween<double>? _rotation;
  late Animation<double> _rotationAnimation;

  final ValueNotifier<bool> _isOffScreen = ValueNotifier<bool>(false);

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scale = visitor(_scale, widget.scale,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _offset = visitor(_offset, widget.offset,
            (dynamic value) => Tween<Offset>(begin: value as Offset))
        as Tween<Offset>?;
    _rotation = visitor(_rotation, widget.rotation,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _scaleAnimation = animation.drive(_scale!);
    _offsetAnimation = animation.drive(_offset!);
    _rotationAnimation = animation.drive(_rotation!);
    super.didUpdateTweens();
  }

  @override
  void initState() {
    super.initState();

    _offsetAnimation.addStatusListener((status) {
      final dx = _offsetAnimation.value.dx;
      final maxOffset = widget.maxOffset;

      if (status.isCompleted && dx < (maxOffset + 10)) {
        _isOffScreen.value = true;
      } else if (status.isAnimating &&
          dx > (maxOffset - 50) &&
          dx < (maxOffset + 50)) {
        _isOffScreen.value = false;
      }
    });
  }

  @override
  void dispose() {
    _isOffScreen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isOffScreen,
      builder: (context, isOffscreen, child) {
        return Visibility(
          visible: !isOffscreen,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: _offsetAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scaleX: _scaleAnimation.value,
                    scaleY: _scaleAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}
