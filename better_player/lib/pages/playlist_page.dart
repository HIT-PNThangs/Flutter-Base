import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../better_player/configuration/better_player_configuration.dart';
import '../better_player/configuration/better_player_data_source.dart';
import '../better_player/configuration/better_player_data_source_type.dart';
import '../better_player/playlist/better_player_playlist.dart';
import '../better_player/playlist/better_player_playlist_configuration.dart';
import '../better_player/playlist/better_player_playlist_controller.dart';
import '../better_player/subtitles/better_player_subtitles_configuration.dart';
import '../better_player/subtitles/better_player_subtitles_source.dart';
import '../better_player/subtitles/better_player_subtitles_source_type.dart';
import '../constants.dart';
import '../utils.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey = GlobalKey();
  final List<BetterPlayerDataSource> _dataSourceList = [];
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;

  _PlaylistPageState() {
    _betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 1,
      fit: BoxFit.cover,
      placeholderOnTop: true,
      showPlaceholderUntilPlay: true,
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(fontSize: 10),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    _betterPlayerPlaylistConfiguration = const BetterPlayerPlaylistConfiguration(
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 3),
    );
  }

  Future<List<BetterPlayerDataSource>> setupData() async {
    _dataSourceList.add(
      BetterPlayerDataSource(BetterPlayerDataSourceType.network, Constants.forBiggerBlazesUrl,
          subtitles: BetterPlayerSubtitlesSource.single(
            type: BetterPlayerSubtitlesSourceType.file,
            url: await Utils.getFileUrl(Constants.fileExampleSubtitlesUrl),
          ),
          placeholder: Image.network(
            Constants.catImageUrl,
            fit: BoxFit.cover,
          )),
    );

    _dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        Constants.bugBuckBunnyVideoUrl,
        placeholder: Image.network(
          Constants.catImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
    _dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        Constants.forBiggerJoyridesVideoUrl,
      ),
    );

    return _dataSourceList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlist"),
      ),
      body: FutureBuilder<List<BetterPlayerDataSource>>(
        future: setupData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Building!");
          } else {
            return ListView(children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("Playlist widget will load automatically next video once current "
                    "finishes. User can't use player controls when video is changing."),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: BetterPlayerPlaylist(
                  key: _betterPlayerPlaylistStateKey,
                  betterPlayerConfiguration: _betterPlayerConfiguration,
                  betterPlayerPlaylistConfiguration: _betterPlayerPlaylistConfiguration,
                  betterPlayerDataSourceList: snapshot.data!,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.setupDataSource(0);
                },
                child: const Text("Change to first data source"),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.setupDataSource(2);
                },
                child: const Text("Change to last source"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("Currently playing video: ${_betterPlayerPlaylistController!.currentDataSourceIndex}");
                },
                child: const Text("Check currently playing video index"),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.betterPlayerController!.pause();
                },
                child: const Text("Pause current video with BetterPlayerController"),
              ),
              ElevatedButton(
                onPressed: () {
                  var list = [
                    BetterPlayerDataSource(
                      BetterPlayerDataSourceType.network,
                      Constants.bugBuckBunnyVideoUrl,
                      placeholder: Image.network(
                        Constants.catImageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  ];
                  _betterPlayerPlaylistController?.setupDataSourceList(list);
                },
                child: const Text("Setup new data source list"),
              ),
            ]);
          }
        },
      ),
    );
  }

  BetterPlayerPlaylistController? get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey.currentState!.betterPlayerPlaylistController;
}
