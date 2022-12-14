import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/utils/modal_scroll_controller.dart';

class ComplexModal extends StatelessWidget {
  const ComplexModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: const Text('Should Close?'),
                    actions: <Widget>[
                      CupertinoButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          shouldClose = true;
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: const Text('No'),
                        onPressed: () {
                          shouldClose = false;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          return shouldClose;
        },
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context) => Builder(
              builder: (context) => CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    leading: Container(), middle: const Text('Modal Page')),
                child: SafeArea(
                  bottom: false,
                  child: ListView(
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: List.generate(
                          100,
                          (index) => ListTile(
                                title: const Text('Item'),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CupertinoPageScaffold(
                                              navigationBar:
                                                  const CupertinoNavigationBar(
                                                middle: Text('New Page'),
                                              ),
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: const <Widget>[],
                                              ))));
                                },
                              )),
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
