import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/iptv_bean.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class TvPlayWidget extends StatefulWidget {
  final IptvBean playData;

  const TvPlayWidget({Key? key, required this.playData}) : super(key: key);

  @override
  State<TvPlayWidget> createState() => _TvPlayWidgetState();
}

class _TvPlayWidgetState extends State<TvPlayWidget> {
  late final videoPlayerController =
      VideoPlayerController.network(widget.playData.playUrl);

  @override
  void initState() {
    super.initState();
    videoPlayerController.initialize().then((value) async {
      videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerWidget = VideoPlayer(videoPlayerController);

    return LayoutBuilder(
      builder: (ctx, layoutCons) => AspectRatio(
        aspectRatio: 1920 / 1080,
        child: playerWidget,
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
