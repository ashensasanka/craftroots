import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import '../resources/save_video.dart';
import '../utils/utils.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadURL;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _byController = TextEditingController();
  final TextEditingController _thumbController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _controller?.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _levelController.dispose();
    _byController.dispose();
    _thumbController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin_Dashboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 55.0, // Adjust the height as needed
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 55.0, // Adjust the height as needed
              child: TextField(
                controller: _byController,
                decoration: InputDecoration(
                  labelText: 'Created By',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 55.0, // Adjust the height as needed
              child: TextField(
                controller: _levelController,
                decoration: InputDecoration(
                  labelText: 'Level',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 55.0, // Adjust the height as needed
              child: TextField(
                controller: _thumbController,
                decoration: InputDecoration(
                  labelText: 'Add Thumbnail link',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _pickVideo();
              },
              child: Text('Add Video'),
            ),
          ),
          _videoURL != null ? _videoPreviewWidget() : Text('No Video Selected'),
        ],
      ),
    );
  }
  void _pickVideo() async {
    _videoURL = await pickVideo();
    _initializeVideoPlayer();
  }
  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });

  }
  Widget _videoPreviewWidget() {
    if (_controller != null) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
          ElevatedButton(onPressed: _uploadVideo, child: Text('Upload'))
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
  void _uploadVideo() async {
    _downloadURL = await StoreData().uploadVideo(_videoURL!);
    await StoreData().saveVideoData(
        _downloadURL!,
        _titleController.text,
        _levelController.text,
        _byController.text,
        _thumbController.text);
    setState(() {
      _videoURL = null;
    });
  }
}

