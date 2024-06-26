import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({super.key, required this.videoURL, required this.videoName});
  final String videoURL;
  final String videoName;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.contentUri(
      Uri.parse(widget.videoURL),
    );
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play video'),
      ),
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            SizedBox(
              height: 20,
            ),
            Text(widget.videoName)
          ],
        ),
      ),
    );
  }
}
