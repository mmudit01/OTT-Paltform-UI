import 'package:better_player/better_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/screens/mainScreen.dart';
import 'package:shott_app/videoPlayer/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'constants.dart';

class PlayWithSubtitlesResume extends StatefulWidget {
  PlayWithSubtitlesResume(this.video,this.id,this.duration);
//
  String video;
  String id;
  int duration;

  @override
  _SubtitlesPageState createState() => _SubtitlesPageState();
}

class _SubtitlesPageState extends State<PlayWithSubtitlesResume> {
  BetterPlayerController _betterPlayerController;
  String userId;
  Future checkUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("userId") != null) {
      setState(() {
        userId = pref.getString("userId");
        //print(userId);
      });
    }
  }
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(

       startAt: Duration(milliseconds: widget.duration),
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.cover,

      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(

        backgroundColor: Colors.green,
        fontColor: Colors.white,
        outlineColor: Colors.black,
        fontSize: 20,
      ),
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _setupDataSource();
    checkUserId();
    super.initState();
  }

  void _setupDataSource() async {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video,

      subtitles: BetterPlayerSubtitlesSource.single(
        type: BetterPlayerSubtitlesSourceType.file,
        url: await Utils.getFileUrl(Constants.fileExampleSubtitlesUrl),
        name: "My subtitles",
        selectedByDefault: true,
      ),
    );
    _betterPlayerController.setupDataSource(dataSource);

  }

  @override
  void dispose() {

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

    ]);
    _betterPlayerController.dispose();


    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Duration d=_betterPlayerController.videoPlayerController.value.position;
        var res = await http.post(
            Uri.encodeFull(
                'https://api.shott.tech/api/resumeplay/$userId'),

            body: {
              "videoid": widget.id,
              "timeid":d.inMilliseconds.toString()
            });
        print(res.body);

        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(

          children: [
        Container(
          width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height ,
        child: AspectRatio(
            aspectRatio: 16/7,
            child: BetterPlayer(controller: _betterPlayerController,)),
        ),
             // SizedBox.expand(
             //      child: FittedBox(
             //        fit: BoxFit.contain,
             //        child: SizedBox(
             //          width: MediaQuery.of(context).size.width,
             //          height: MediaQuery.of(context).size.height,
             //          child:
             //        ),
             //      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 30, 20, 0),
                      child: Image.asset("assets/shott_logo.png",height: 18,)
                    )
                  ],
                ),

              ],
            ),
          ],
        )
      ),
    );
  }
}
