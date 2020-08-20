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
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((value) {
        setState(() {});
      });
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
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
