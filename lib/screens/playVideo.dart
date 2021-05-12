// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shott_app/constants/colors.dart';
// import 'package:video_player/video_player.dart';
//
// class PlayVideo extends StatefulWidget {
//   PlayVideo(this.video);
// //
//   String video;
//   @override
//   _PlayVideoState createState() => _PlayVideoState();
// }
//
// class _PlayVideoState extends State<PlayVideo> {
//   // VideoPlayerController _controller;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.network(
//   //       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
//   //     ..setVolume(1.0)
//   //     ..initialize().then((_) {
//   //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//   //       setState(() {});
//   //     });
//   // }
//
//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller.dispose();
//   // }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Stack(overflow: Overflow.visible, children: [
//   //       Center(
//   //         child: _controller.value.initialized
//   //             ? AspectRatio(
//   //                 aspectRatio: _controller.value.aspectRatio,
//   //                 child: VideoPlayer(_controller),
//   //               )
//   //             : Container(),
//   //       ),
//   //       Container(
//   //           width: 30,
//   //           color: Colors.yellow,
//   //           child: GestureDetector(
//   //             onTap: () {
//   //               setState(() {
//   //                 _controller.value.isPlaying
//   //                     ? _controller.pause()
//   //                     : _controller.play();
//   //               });
//   //             },
//   //             child: Icon(
//   //               _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//   //             ),
//   //           ))
//   //     ]),
//   //     // body: Center(
//   //     //   child: _controller.value.initialized
//   //     //       ? AspectRatio(
//   //     //           aspectRatio: _controller.value.aspectRatio,
//   //     //           child: VideoPlayer(_controller),
//   //     //         )
//   //     //       : Container(),
//   //     // ),
//   //     // floatingActionButton: FloatingActionButton(
//   //     //   onPressed: () {
//   //     //     setState(() {
//   //     //       _controller.value.isPlaying
//   //     //           ? _controller.pause()
//   //     //           : _controller.play();
//   //     //     });
//   //     //   },
//   //     //   child: Icon(
//   //     //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//   //     //   ),
//   //     // ),
//   //   );
//    VideoPlayerController _videoPlayerController;
//    ChewieController _chewieController;
//
//    double _aspectRatio = 16 / 9;
//    @override
//    initState() {
//      //print(widget.video);
//      super.initState();
//      SystemChrome.setPreferredOrientations([
//        DeviceOrientation.landscapeLeft,
//      ]);
//      _videoPlayerController = VideoPlayerController.network(widget.video,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
//        ..addListener(checkVideo);
//      _chewieController = ChewieController(
//        allowedScreenSleep: false,
//
//        allowPlaybackSpeedChanging: false,
//        allowFullScreen: false,
//        allowMuting: true,
//        showControlsOnInitialize: false,
//        fullScreenByDefault: true,
//        deviceOrientationsAfterFullScreen: [
//          DeviceOrientation.landscapeLeft,
//        ],
//
//        videoPlayerController: _videoPlayerController,
//
//        aspectRatio: _aspectRatio,
//        autoInitialize: true,
//        autoPlay: true,
//        showControls: true,
//      );
//      _chewieController.addListener(() {
//        if (!_chewieController.isFullScreen) {
//          _videoPlayerController.pause();
//        }
//      });
//    }
//
//    @override
//    void dispose() {
//      SystemChrome.setPreferredOrientations([
//        DeviceOrientation.portraitUp,
//      ]);
//      _videoPlayerController.dispose();
//      _chewieController.dispose();
//      super.dispose();
//    }
//
//    void checkVideo() {
//      // Implement your calls inside these conditions' bodies :
//      if (_videoPlayerController.value.position ==
//          Duration(seconds: 0, minutes: 0, hours: 0)) {}
//
//      if (_videoPlayerController.value.position ==
//          _videoPlayerController.value.duration) {
//        SystemChrome.setPreferredOrientations([
//          DeviceOrientation.portraitUp,
//        ]);
//      }
//    }
//
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        backgroundColor: black,
//        body: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          child: Chewie(
//            controller: _chewieController,
//          ),
//        ),
//      );
//    }
//  }
