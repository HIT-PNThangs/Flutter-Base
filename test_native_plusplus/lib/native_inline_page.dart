import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'destination.dart';

class NativeInlinePage extends StatefulWidget {
  final List<Destination> entries;

  const NativeInlinePage({
    required this.entries,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  static const _kAdIndex = 4;
  NativeAd? _ad;

  @override
  void initState() {
    super.initState();

    // COMPLETE: Load a native ad
    NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as NativeAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          debugPrint('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Ad'),
      ),
      body:

      // ListView.separated(
      //   physics: const BouncingScrollPhysics(),
      //   shrinkWrap: true,
      //   itemBuilder: (context, index) {
      //     final item = widget.entries[_getDestinationItemIndex(index)];
      //
      //     return ListTile(
      //       leading: Image.asset(
      //         item.asset,
      //         width: 48,
      //         height: 48,
      //         package: 'flutter_gallery_assets',
      //         fit: BoxFit.cover,
      //       ),
      //       title: Text(item.name),
      //       subtitle: Text(item.duration),
      //       onTap: () {
      //         debugPrint('Clicked ${item.name}');
      //       },
      //     );
      //   },
      //   separatorBuilder: (context, index) {
      //     if (index % 5 == 3 && index != 0) {
      //       return _ad != null
      //           ? Container(
      //               height: 72.0,
      //               alignment: Alignment.center,
      //               child: AdWidget(ad: _ad!),
      //             )
      //           : const SizedBox.shrink();
      //     }
      //     return const SizedBox();
      //   },
      //   itemCount: widget.entries.length,
      // ),

      ListView.builder(
        itemCount: widget.entries.length + (_ad != null ? 1 : 0),
        itemBuilder: (context, index) {
          // COMPLETE: Render a native ad
          if (_ad != null && index == _kAdIndex) {
            return Container(
              height: 72.0,
              alignment: Alignment.center,
              child: AdWidget(ad: _ad!),
            );
          } else {
            final item = widget.entries[_getDestinationItemIndex(index)];

            return ListTile(
              leading: Image.asset(
                item.asset,
                width: 48,
                height: 48,
                package: 'flutter_gallery_assets',
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text(item.duration),
              onTap: () {
                debugPrint('Clicked ${item.name}');
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _ad != null) {
      return rawIndex - 1;
    }

    return rawIndex;
  }
}
