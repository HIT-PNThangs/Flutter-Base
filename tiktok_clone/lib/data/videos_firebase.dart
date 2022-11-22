import 'package:cloud_firestore/cloud_firestore.dart';

import 'demo_data.dart';
import 'video.dart';

class VideosAPI {
  List<Video> listVideos = <Video>[];

  VideosAPI() {
    load();
  }

  void load() async {
    listVideos = await getVideoList();
  }

  Future<List<Video>> getVideoList() async {
    var data = await FirebaseFirestore.instance.collection("videos").get();

    var videoList = <Video>[];
    var videos;

    if (data.docs.isEmpty) {
      await addDemoData();
      videos = (await FirebaseFirestore.instance.collection("Videos").get());
    } else {
      videos = data;
    }

    videos.docs.forEach((element) {
      Video video = Video.fromJson(element.data());
      videoList.add(video);
    });

    return videoList;
  }

  Future<void> addDemoData() async {
    for (var video in data) {
      await FirebaseFirestore.instance.collection("Videos").add(video);
    }
  }
}