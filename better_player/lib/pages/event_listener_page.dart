import 'dart:async';

import 'package:flutter/material.dart';

import '../better_player/configuration/better_player_configuration.dart';
import '../better_player/configuration/better_player_data_source.dart';
import '../better_player/configuration/better_player_data_source_type.dart';
import '../better_player/configuration/better_player_event.dart';
import '../better_player/core/better_player.dart';
import '../better_player/core/better_player_controller.dart';
import '../constants.dart';

class EventListenerPage extends StatefulWidget {
  const EventListenerPage({super.key});

  @override
  _EventListenerPageState createState() => _EventListenerPageState();
}

class _EventListenerPageState extends State<EventListenerPage> {
  late BetterPlayerController _betterPlayerController;
  List<BetterPlayerEvent> events = [];
  final StreamController<DateTime> _eventStreamController = StreamController.broadcast();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, Constants.elephantDreamVideoUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.addEventsListener(_handleEvent);
    super.initState();
  }

  @override
  void dispose() {
    _eventStreamController.close();
    _betterPlayerController.removeEventsListener(_handleEvent);
    super.dispose();
  }

  void _handleEvent(BetterPlayerEvent event) {
    events.insert(0, event);

    ///Used to refresh only list of events
    _eventStreamController.add(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event listener"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Better Player exposes events which can be listened with event "
              "listener. Start player to see events flowing.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder(
              stream: _eventStreamController.stream,
              builder: (context, snapshot) {
                return ListView(
                  children: events
                      .map(
                        (event) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Event: ${event.betterPlayerEventType} "
                                "parameters: ${(event.parameters ?? <String, dynamic>{}).toString()}"),
                            const Divider(),
                          ],
                        ),
                      )
                      .toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
