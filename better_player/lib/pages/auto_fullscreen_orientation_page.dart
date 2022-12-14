import 'package:flutter/material.dart';

import '../better_player/configuration/better_player_configuration.dart';
import '../better_player/configuration/better_player_data_source.dart';
import '../better_player/configuration/better_player_data_source_type.dart';
import '../better_player/core/better_player.dart';
import '../better_player/core/better_player_controller.dart';
import '../constants.dart';

class AutoFullscreenOrientationPage extends StatefulWidget {
  const AutoFullscreenOrientationPage({super.key});

  @override
  _AutoFullscreenOrientationPageState createState() => _AutoFullscreenOrientationPageState();
}

class _AutoFullscreenOrientationPageState extends State<AutoFullscreenOrientationPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(aspectRatio: 16 / 9, fit: BoxFit.contain, autoDetectFullscreenDeviceOrientation: true);
    BetterPlayerDataSource dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, Constants.forBiggerBlazesUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auto full screen orientation"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Aspect ratio and device orientation on full screen will be "
              "managed by the BetterPlayer. Click on the fullscreen option.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
          ElevatedButton(
            child: const Text("Play horizontal video"),
            onPressed: () {
              BetterPlayerDataSource dataSource =
                  BetterPlayerDataSource(BetterPlayerDataSourceType.network, Constants.forBiggerBlazesUrl);
              _betterPlayerController.setupDataSource(dataSource);
            },
          ),
          ElevatedButton(
            child: const Text("Play vertical video"),
            onPressed: () async {
              BetterPlayerDataSource dataSource =
                  BetterPlayerDataSource(BetterPlayerDataSourceType.network, Constants.verticalVideoUrl);
              _betterPlayerController.setupDataSource(dataSource);
            },
          ),
        ],
      ),
    );
  }
}
