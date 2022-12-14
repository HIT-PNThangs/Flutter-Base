import 'package:flutter/material.dart';

import '../../../src/route/sheet_route.dart';
import '../../../src/sheet.dart';

class MaterialSheetRoute<T> extends SheetRoute<T> {
  MaterialSheetRoute({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color barrierColor = Colors.black87,
    SheetFit fit = SheetFit.expand,
    Curve? animationCurve,
    bool barrierDismissible = true,
    bool enableDrag = true,
    List<double>? stops,
    double initialStop = 1,
    Duration? duration,
  }) : super(
          builder: (BuildContext context) => Material(
            color: backgroundColor,
            clipBehavior: clipBehavior ?? Clip.none,
            shape: shape,
            elevation: elevation ?? 1,
            child: Builder(
              builder: builder,
            ),
          ),
          stops: stops,
          initialExtent: initialStop,
          fit: fit,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          draggable: enableDrag,
          animationCurve: animationCurve,
          duration: duration,
        );
}
