import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:video_player/video_player.dart';

enum RewardType { DOWNLOAD, APPLY }

class HomeController extends GetxController {
  Map data = {};
  AppController appController = Get.find<AppController>();

  RxInt currentIndex = 0.obs;


  RxBool showDownloading = false.obs;
  RxString type = ''.obs;
  RxString link = ''.obs;
  String video = '';
  Rx<Widget> containerBanner = Container().obs;
  final AppController _appController = Get.find<AppController>();
  bool isAdRewardDone = false;
  RxBool showRewardSuccessView = false.obs;
  RxBool hideBanner = false.obs;
  Rx<RewardType> rewardType = RewardType.DOWNLOAD.obs;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  Chewie? playerWidget;
  RxBool showPlayerWidget = false.obs;
  String _videoPath = '';
  RxDouble scaleVideo = 1.0.obs;

  @override
  void onInit() {
    super.onInit();

    data = appController.list[0];
  }

  void changeIndex(int value) {
    currentIndex.value = value;
  }
}
