import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/feed_screen.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setup();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedScreen(),
  ));
}