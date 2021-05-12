// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fullscreen/fullscreen.dart';
// import 'package:shott_app/constants/colors.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_player_controls/video_player_controls.dart';
//
// class play extends StatefulWidget {
//   play(this.video);
// //
//   String video;
//   @override
//   _playState createState() => _playState();
// }
//
// class _playState extends State<play> {
//   Controller controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = new Controller(
//       items: [
//         //
//         new PlayerItem(
//           title: 'video 1',
//           url:
//           widget.video,
//           // subtitleUrl: "https://wecast.ch/posters/vt.vtt",
//         ),
//
//       ],
//       autoPlay: true,
//       errorBuilder: (context, message) {
//         return new Container(
//           child: new Text(message),
//         );
//       },
//       // index: 2,
//       allowFullScreen: true,
//
//       autoInitialize: true,
//       // isLooping: false,
//       allowedScreenSleep: false,
//       // showControls: false,
//       hasSubtitles: true,
//       // isLive: true,
//       // showSeekButtons: false,
//       // showSkipButtons: false,
//       // allowFullScreen: false,
//       fullScreenByDefault: false,
//       // placeholder: new Container(
//       //   color: Colors.grey,
//       // ),
//       isPlaying: (isPlaying) {
//         //
//         // print(isPlaying);
//       },
//
//       playerItem: (playerItem) {
//         // print('Player title: ' + playerItem.title);
//         // print('position: ' + playerItem.position.inSeconds.toString());
//         // print('Duration: ' + playerItem.duration.inSeconds.toString());
//       },
//       videosCompleted: (isCompleted) {
//         print(isCompleted);
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: VideoPlayerControls(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
//
