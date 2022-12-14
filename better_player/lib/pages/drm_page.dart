import 'package:flutter/material.dart';

import '../better_player/configuration/better_player_configuration.dart';
import '../better_player/configuration/better_player_data_source.dart';
import '../better_player/configuration/better_player_data_source_type.dart';
import '../better_player/configuration/better_player_drm_configuration.dart';
import '../better_player/configuration/better_player_drm_type.dart';
import '../better_player/configuration/better_player_video_format.dart';
import '../better_player/core/better_player.dart';
import '../better_player/core/better_player_controller.dart';
import '../constants.dart';

class DrmPage extends StatefulWidget {
  const DrmPage({super.key});

  @override
  _DrmPageState createState() => _DrmPageState();
}

class _DrmPageState extends State<DrmPage> {
  late BetterPlayerController _tokenController;
  late BetterPlayerController _widevineController;
  late BetterPlayerController _fairplayController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource _tokenDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.tokenEncodedHlsUrl,
      videoFormat: BetterPlayerVideoFormat.hls,
      drmConfiguration:
          BetterPlayerDrmConfiguration(drmType: BetterPlayerDrmType.token, token: Constants.tokenEncodedHlsToken),
    );
    _tokenController = BetterPlayerController(betterPlayerConfiguration);
    _tokenController.setupDataSource(_tokenDataSource);

    _widevineController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _widevineDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.widevineVideoUrl,
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.widevine, licenseUrl: Constants.widevineLicenseUrl, headers: {"Test": "Test2"}),
    );
    _widevineController.setupDataSource(_widevineDataSource);

    _fairplayController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _fairplayDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.fairplayHlsUrl,
      drmConfiguration: BetterPlayerDrmConfiguration(
        drmType: BetterPlayerDrmType.fairplay,
        certificateUrl: Constants.fairplayCertificateUrl,
        licenseUrl: Constants.fairplayLicenseUrl,
      ),
    );
    _fairplayController.setupDataSource(_fairplayDataSource);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DRM player"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Auth token based DRM.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _tokenController),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Widevine - license url based DRM. Works only for Android.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _widevineController),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Fairplay - certificate url based EZDRM. Works only for iOS.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _fairplayController),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
