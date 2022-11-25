import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../src/physics.dart';
import '../../src/sheet.dart';

class BounceTopSheet extends StatelessWidget {
  const BounceTopSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Sheet(
      physics: const BouncingSheetPhysics(),
      maxExtent: 300,
      minExtent: 100,
      child: Container(),
    );
  }
}

class BouncingSheetPage extends StatefulWidget {
  const BouncingSheetPage({super.key});

  @override
  _BouncingSheetPageState createState() => _BouncingSheetPageState();
}

class _BouncingSheetPageState extends State<BouncingSheetPage> {
  final SheetController controller = SheetController();

  double minExtent = 0;

  @override
  void initState() {
    Future<void>.delayed(const Duration(milliseconds: 400), animateSheet);

    super.initState();
  }

  void animateSheet() {
    controller
        .animateTo(
      100,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    )
        .then(
      (_) {
        setState(() {
          minExtent = 100;
        });
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sheet(
      minExtent: minExtent,
      maxExtent: 400,
      elevation: 4,
      physics: const BouncingSheetPhysics(),
      controller: controller,
      child: Container(),
    );
  }
}
