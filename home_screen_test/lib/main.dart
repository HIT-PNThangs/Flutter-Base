import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/binding/app_binding.dart';
import 'package:home_screen_test/app/route/app_pages.dart';
import 'package:home_screen_test/app/ui/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        initialRoute: AppRoute.splash_screen,
        getPages: AppPages.pages,
        theme: ThemeData(brightness: Brightness.dark)
    );
  }
}