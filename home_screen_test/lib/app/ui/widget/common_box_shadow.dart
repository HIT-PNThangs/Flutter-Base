import 'package:flutter/material.dart';

class CommonBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CommonBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    double spreadRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(
            color: color,
            offset: offset,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}