import 'dart:async';

import 'package:flutter/material.dart';

import 'custom_loading.dart';
import 'src/DynamicListView.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.amber),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.1)),
          child: DynamicListView.build(
            itemBuilder: _itemBuilder,
            dataRequester: _dataRequester,
            initRequester: _initRequester,
            moreLoadingWidget: const CustomLoading(),
            initLoadingWidget: const CustomLoading(),
          ),
        ),
      ),
    );
  }

  Future<List> _initRequester() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return List.generate(15, (i) => i);
    });
  }

  Future<List> _dataRequester() async {
    return Future.delayed(const Duration(seconds: 5), () {
      return List.generate(10, (i) => 15 + i);
    });
  }

  final Function _itemBuilder = (List dataList, BuildContext context, int index) {
    String title = dataList[index].toString();
    return ListTile(title: Text("Number $title"));
  };
}
