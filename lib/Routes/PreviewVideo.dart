import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class PreviewVideo extends StatefulWidget {
  PreviewVideo({this.url});

  String url;

  @override
  _PreviewVideoState createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(widget.url)
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Video Preview"),
      ),
      body: Container(
        child: Center(
          child: AspectRatio(
            aspectRatio: 1.5,
            child: FlickVideoPlayer(
                flickManager: flickManager
            ),
          ),
        ),
      ),
    );
  }
}