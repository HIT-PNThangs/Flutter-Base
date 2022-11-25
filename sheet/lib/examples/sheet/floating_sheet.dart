import 'package:flutter/material.dart';

import '../../src/physics.dart';
import '../../src/sheet.dart';

class FloatingSheet extends StatefulWidget {
  const FloatingSheet({super.key});

  @override
  _FitSheetState createState() => _FitSheetState();
}

class _FitSheetState extends State<FloatingSheet> {
  final SheetController controller = SheetController();

  @override
  void initState() {
    Future<void>.delayed(const Duration(milliseconds: 400), animateSheet);

    super.initState();
  }

  void animateSheet() {
    controller.relativeAnimateTo(1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sheet.raw(
      physics: const SnapSheetPhysics(
        parent: BouncingSheetPhysics(overflowViewport: false),
        stops: <double>[0, 1],
      ),
      padding: const EdgeInsets.all(20),
      controller: controller,
      child: Container(
        height: 200,
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Material(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.grey[900],
          ),
        ),
      ),
    );
  }
}
