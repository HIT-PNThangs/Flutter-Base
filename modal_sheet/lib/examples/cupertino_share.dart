import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/bottom_sheets/cupertino_bottom_sheet.dart';
import '../src/utils/modal_scroll_controller.dart';

class CupertinoSharePage extends StatelessWidget {
  const CupertinoSharePage({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
        middle: Column(
          children: <Widget>[
            Text(
              'New York',
              style: baseTextStyle,
            ),
            Text(
              '1 February 11:45',
              style: baseTextStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Text('Edit'),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: 'image',
                child: Image.asset('assets/demo_image.jpeg'),
              ),
            ),
          ),
          bottomAppBar(context),
        ],
      ),
    );
  }

  Widget bottomAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: CupertinoColors.separator.resolveFrom(context),
          ),
        ),
        color: CupertinoTheme.of(context).barBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            child: const Icon(
              CupertinoIcons.share,
              size: 28,
            ),
            onPressed: () {
              showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const PhotoShareBottomSheet(),
              );
            },
          ),
          const CupertinoButton(
            onPressed: null,
            child: Icon(CupertinoIcons.heart, size: 28),
          ),
          const CupertinoButton(
            onPressed: null,
            child: Icon(CupertinoIcons.delete, size: 28),
          )
        ],
      ),
    );
  }
}

class PhotoShareBottomSheet extends StatelessWidget {
  const PhotoShareBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          extendBodyBehindAppBar: true,
          appBar: appBar(context),
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: ModalScrollController.of(context),
            slivers: <Widget>[
              SliverSafeArea(
                bottom: false,
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 318,
                    child: ListView(
                      padding: const EdgeInsets.all(12).copyWith(right: MediaQuery.of(context).size.width / 2 - 100),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Hero(
                              tag: 'image',
                              child: Image.asset('assets/demo_image.jpeg'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/demo_image.jpeg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/demo_image.jpeg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),
              sliverContactsSection(context),
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.only(top: 12),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return Container(
                        width: 72,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: <Widget>[
                            if (app.imageUrl != null)
                              Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 12,
                                shadowColor: Colors.black12,
                                child: ClipRRect(
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(app.imageUrl!), fit: BoxFit.cover),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            Text(
                              app.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: apps.length,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    List<Widget>.from(
                      actions.map(
                        (action) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: CupertinoColors.tertiarySystemGroupedBackground.resolveFrom(context),
                          ),
                          child: Text(
                            action.title,
                            style: CupertinoTheme.of(context).textTheme.textStyle,
                          ),
                        ),
                      ),
                    ).addItemInBetween(
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: CupertinoColors.separator.resolveFrom(context),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    List<Widget>.from(
                      actions1.map(
                        (action) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: action == actions1.first ? const Radius.circular(8) : Radius.zero,
                              topRight: action == actions1.first ? const Radius.circular(8) : Radius.zero,
                              bottomLeft: action == actions1.last ? const Radius.circular(8) : Radius.zero,
                              bottomRight: action == actions1.last ? const Radius.circular(8) : Radius.zero,
                            ),
                            color: CupertinoColors.tertiarySystemGroupedBackground.resolveFrom(context),
                          ),
                          child: Text(
                            action.title,
                            style: CupertinoTheme.of(context).textTheme.textStyle,
                          ),
                        ),
                      ),
                    ).addItemInBetween(
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: CupertinoColors.separator.resolveFrom(context),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    List<Widget>.from(
                      actions2.map(
                        (action) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: action == actions2.first ? const Radius.circular(8) : Radius.zero,
                              topRight: action == actions2.first ? const Radius.circular(8) : Radius.zero,
                              bottomLeft: action == actions2.last ? const Radius.circular(8) : Radius.zero,
                              bottomRight: action == actions2.last ? const Radius.circular(8) : Radius.zero,
                            ),
                            color: CupertinoColors.tertiarySystemGroupedBackground.resolveFrom(context),
                          ),
                          child: Text(
                            action.title,
                            style: CupertinoTheme.of(context).textTheme.textStyle,
                          ),
                        ),
                      ),
                    ).addItemInBetween(
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: CupertinoColors.separator.resolveFrom(context),
                      ),
                    ),
                  ),
                ),
              ),
              const SliverSafeArea(
                top: false,
                sliver: SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sliverContactsSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 132,
        padding: const EdgeInsets.only(top: 12),
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final person = people[index];
            return Container(
              width: 72,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: <Widget>[
                  if (person.imageUrl != null)
                    Material(
                      shape: const CircleBorder(),
                      elevation: 12,
                      shadowColor: Colors.black12,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          person.imageUrl!,
                        ),
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    person.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                  )
                ],
              ),
            );
          },
          itemCount: people.length,
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 74),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(width: 18),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/demo_image.jpeg',
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              '1 Photo selected',
                              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  'Options',
                                  style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 14,
                                  color: CupertinoTheme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 14),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.secondarySystemFill.resolveFrom(context),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: CupertinoColors.systemFill.resolveFrom(context),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                    ],
                  ),
                ),
                const Divider(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String title;
  final String? imageUrl;

  Item(this.title, this.imageUrl);
}

final people = [
  Item('MacBook Pro', 'assets/MacBook.jpg'),
  Item('Jaime Blasco', 'assets/jaimeblasco.jpeg'),
  Item('Mya Johnston', 'assets/person1.jpeg'),
  // https://images.unsplash.com/photo-1520813792240-56fc4a3765a7'
  Item('Maxime Nicholls', 'assets/person4.jpeg'), //https://images.unsplash.com/photo-1568707043650-eb03f2536825'
  Item('Susanna Thorne', 'assets/person2.jpeg'), //https://images.unsplash.com/photo-1520719627573-5e2c1a6610f0
  Item('Jarod Aguilar', 'assets/person3.jpeg')
  //https://images.unsplash.com/photo-1547106634-56dcd53ae883
];

final apps = [
  Item('Messages', 'assets/message.png'),
  Item('Github', 'assets/github_app.png'),
  Item('Slack', 'assets/slack.png'),
  Item('Twitter', 'assets/twitter.png'),
  Item('Mail', 'assets/mail.png'),
];

final actions = [
  Item('Copy Photo', null),
];
final actions1 = [
  Item('Add to Shared Album', null),
  Item('Add to Album', null),
  Item('Duplicate', null),
  Item('Hide', null),
  Item('Slideshow', null),
  Item('AirPlay', null),
  Item('Use as Wallpaper', null),
];

final actions2 = [
  Item('Create Watch', null),
  Item('Save to Files', null),
  Item('Asign to Contact', null),
  Item('Print', null),
];

extension ListUtils<T> on List<T> {
  List<T> addItemInBetween<A extends T>(A item) =>
      length == 0 ? this : (fold([], (r, element) => [...r, element, item])..removeLast());
}

class SimpleSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SimpleSliverDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(height: height, child: child);
  }

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
