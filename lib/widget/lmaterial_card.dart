import 'package:flutter/material.dart';


class MaterialCard extends StatelessWidget {
  final int index;
  final String name;
  final String videoUrl;
  final Function onTap;

  const MaterialCard({
    Key? key,
    required this.name,
    required this.videoUrl,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoPlayerWidget(videoUrl: Uri.parse(videoUrl)), // Parse the videoUrl to Uri
              const SizedBox(width: 28),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final Uri videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.networkUrl(widget.videoUrl)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return AspectRatio(
    //   aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
    //   child: _controller.value.isInitialized
    //       ? VideoPlayer(_controller)
    //       : CircularProgressIndicator(), // Show loading indicator until video is initialized
    // );
  }
}
