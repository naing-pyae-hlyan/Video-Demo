import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
//        'http://techslides.com/demos/sample-videos/small.mp4'
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Demo'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _bodyWidget(context),
      floatingActionButton: _fabWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        print('mData: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
          );
        } else {
          return AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _fabWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          if (_videoPlayerController.value.isPlaying) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
        });
      },
      child: Icon(_videoPlayerController.value.isPlaying
          ? Icons.pause
          : Icons.play_arrow),
    );
  }
}
