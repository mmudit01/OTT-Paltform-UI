import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/models/Favourite.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/screens/sub/subfromMoviedetail.dart';
import 'package:shott_app/services/apiProvider.dart';
import 'package:shott_app/videoPlayer/FromResume.dart';
import 'package:shott_app/videoPlayer/subtitleVideoPlayer.dart';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

import '../videoPlayer/FromResume.dart';

class MovieDetails extends StatefulWidget {
  final bool authenticated;
  final Movie movie;
  final String movieid;
  final List<String> fav;
  final int time;
  MovieDetails({this.authenticated, this.movie, this.movieid, this.fav,this.time});
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret =
      "sk_test_51IX1o4SB0gSsu8cgnH2ZWC5wlqoJKv7vdst9uCfeR6OAUPYINk89Oqdf3kPMru6xgS2PET3KPQdu0CYTQc36aQFR00FGh384rr"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();
  Favorite favorite;

  final CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool authenticate;
  Future checkUserAuthenticate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("authenticated") != null) {
      setState(() {
        authenticate = pref.getBool("authenticated");
        //print(authenticate);
      });
    }
  }

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

  String sub;
  Future checkUserSub() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("sub") != null) {
      setState(() {
        sub = pref.getString("sub");
        //print(sub);
      });
    }
  }
  int duration;
  Future checkMovieDuration() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("Duration") != null) {
      setState(() {
        duration = pref.getInt("Duration");
      //  print(duration);
      });
    }else{
      setState(() {
        duration = 0;
        //print(sub);
      });
    }
  }

  List<String> f = ["123", "456987"];

  bool isPresent(String MovieName) {
    return f.contains(MovieName);
  }

  @override
  void initState() {
    super.initState();
    if (widget.fav != null) {
      f = widget.fav;
      //print("f");
      //print(f);
    }
    checkUserAuthenticate();
    checkUserId();
    checkUserSub();
    checkMovieDuration();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IX1o4SB0gSsu8cg4mxASlX5BgEFJO7NYfVbNHnfRHmps8tOzn8XoP14yl894TJv3vC2pxSRSduMaE5gzo2XRxLW00gYpG8hHv",
        merchantId: "",
        androidPayMode: "test"));
  }

  void setError(dynamic error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // ignore: deprecated_member_use
    // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: TextStyle(
              color: black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: orangeColor),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.movie.bannerimage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // duration!=0? ClipRRect(
                    //   borderRadius: BorderRadius.circular(5),
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       //print(sub);
                    //       //print(widget.movieid);
                    //       //print(widget.movie.id);
                    //       String i = widget.movieid;
                    //       //print(i);
                    //       //print(sub);
                    //       String link = widget.movie.video;
                    //       //print(link);
                    //       if (authenticate == true) {
                    //         if (sub == "yes") {
                    //           // String link1 =
                    //           //     "https://api.shott.tech/api/addtohistory/$i/$userId";
                    //           // var res = await http.get(Uri.encodeFull(link1),
                    //           //     headers: {"Accept": "application/json"});
                    //           // if (res.statusCode == 200) {
                    //           //   var data = json.decode(res.body);
                    //           //   print(data);
                    //           // }
                    //
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (context) => PlayWithSubtitlesResume(link, i,duration  )));
                    //         } else {
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (context) => subMovied(
                    //                 movie: widget.movie,
                    //               )));
                    //         }
                    //       } else {
                    //         Navigator.of(context)
                    //             .pushNamed("/signIn", arguments: widget.movie);
                    //       }
                    //     },
                    //     child: Container(
                    //       width: authenticate == true ? 150 : 70,
                    //       height: 30,
                    //       color: authenticate == true ? blueColor : Colors.red,
                    //       child: Center(
                    //         child: Text(
                    //           authenticate == true ? "Resume" : "Resume",
                    //           style: TextStyle(color: white, fontSize: 15),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ):
                   // Container(),
                   // SizedBox(width: 20,),
                   widget.time==0? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: GestureDetector(
                        onTap: () async {
                          //print(sub);
                          //print(widget.movieid);
                          //print(widget.movie.id);
                          String i = widget.movieid;
                          //print(i);
                          //print(sub);
                          String link = widget.movie.video;
                          //print(link);
                          if (authenticate == true) {
                            if (sub == "yes") {
                              String link1 =
                                  "https://api.shott.tech/api/addtohistory/$i/$userId";
                              var res = await http.get(Uri.encodeFull(link1),
                                  headers: {"Accept": "application/json"});
                              if (res.statusCode == 200) {

                                print(res.body);
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlayWithSubtitles(link, i)));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => subMovied(
                                        movie: widget.movie,
                                      )));
                            }
                          } else {
                            Navigator.of(context)
                                .pushNamed("/signIn", arguments: widget.movie);
                          }
                        },
                        child: Container(
                          width: authenticate == true ? 150 : 70,
                          height: 30,
                          color: authenticate == true ? blueColor : Colors.red,
                          child: Center(
                            child: Text(
                              authenticate == true ? "Play" : "Play",
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ):ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: GestureDetector(
                       onTap: () async {
                         //print(sub);
                         //print(widget.movieid);
                         //print(widget.movie.id);
                         String i = widget.movieid;
                         //print(i);
                         //print(sub);
                         String link = widget.movie.video;
                         //print(link);
                         if (authenticate == true) {
                           if (sub == "yes") {
                             String link1 =
                                 "https://api.shott.tech/api/addtohistory/$i/$userId";
                             var res = await http.get(Uri.encodeFull(link1),
                                 headers: {"Accept": "application/json"});


                             Navigator.of(context).push(MaterialPageRoute(
                                 builder: (context) => PlayWithSubtitlesResume(link, i,widget.time)));
                           } else {
                             Navigator.of(context).push(MaterialPageRoute(
                                 builder: (context) => subMovied(
                                   movie: widget.movie,
                                 )));
                           }
                         } else {
                           Navigator.of(context)
                               .pushNamed("/signIn", arguments: widget.movie);
                         }
                       },
                       child: Container(
                         width: authenticate == true ? 150 : 70,
                         height: 30,
                         color: authenticate == true ? blueColor : Colors.red,
                         child: Center(
                           child: Text(
                             "Continue Playing",
                             style: TextStyle(color: white, fontSize: 15),
                           ),
                         ),
                       ),
                     ),
                   )


                    // authenticate==true
                    //     ? Container()
                    //     : Padding(
                    //         padding: const EdgeInsets.only(right: 7.0),
                    //         child: Text(
                    //           "Rs.${widget.movie.price}",
                    //           style: TextStyle(color: black, fontSize: 15),
                    //         ),
                    //       )
                  ],
                ),
              ),
              row_After_Play(),
              crew(
                title: "Crew",
                context: context,
                id: widget.movie.id,
              ),
              description(),
            ],
          ),
        ),
      ),
    );
  }

  Widget row_After_Play() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  "assets/movieDetailsIcons/language_icon.png",
                  width: 25,
                  height: 25,
                ),
              ),
              Text(
                "English",
                style: TextStyle(color: black, fontSize: 13),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  "assets/movieDetailsIcons/bookmark_icon.png",
                  width: 20,
                  height: 20,
                ),
              ),
              InkWell(
                onTap: () async {
                  if (authenticate == true) {
                    List<String> fav = [];
                    String mi = widget.movie.id;
                    print(mi);
                    print(userId);
                    //print("fav");
                    String link =
                        "https://api.shott.tech/api/addtofavioret/$mi/$userId";
                    var res = await http.post(Uri.encodeFull(link),
                        headers: {"Accept": "application/json"});
                    //print(res.body);
                    var data = json.decode(res.body);
                    String msg;
                    if (data["already"] ==
                        "This is already in the favorite list!") {
                      msg = data["already"];
                    } else {
                      msg = data["success"];
                    }
                    //print(data["already"]);

                    if (res.statusCode == 200) {
                      Fluttertoast.showToast(
                          msg: msg,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.orangeAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    Navigator.of(context)
                        .pushNamed("/signIn", arguments: widget.movie);
                  }
                },
                child: Text(
                  "Add To Favorites",
                  style: TextStyle(color: black, fontSize: 13),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  "assets/movieDetailsIcons/bookmark_icon.png",
                  width: 20,
                  height: 20,
                ),
              ),
              InkWell(
                onTap: () async {
                  if (authenticate == true) {
                    String mi = widget.movie.id;
                    //print(mi);

                    //print("watch");
                    final uri =
                        "https://api.shott.tech/api/addtowatch/$mi/$userId";
                    final headers = {
                      'Content-Type': 'application/x-www-form-urlencoded'
                    }; //if required
                    Response getResponse = await get(uri, headers: headers);
                    int statusCode = getResponse.statusCode;
                    String responseBody = getResponse.body;
                    var data = json.decode(responseBody);
                    //print(data);
                    String msg;
                    if (data["already"] ==
                        "This is already in the watch list!") {
                      msg = data["already"];
                    } else {
                      msg = data["added"];
                    }
                    if (statusCode == 200) {
                      //print(msg);
                      Fluttertoast.showToast(
                          msg: msg,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.orangeAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    Navigator.of(context)
                        .pushNamed("/signIn", arguments: widget.movie);
                  }
                },
                child: Text(
                  "Add To WatchList",
                  style: TextStyle(color: black, fontSize: 13),
                ),
              )
            ],
          )
        ],
      ),
    );
  }



  Widget crew({BuildContext context, String title, String id}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              // onTap: () {
              //   Navigator.of(context).pushNamed("/latestVideos");
              // },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            )
          ],
        ),
      ),
      Padding(
        padding:
        const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
        child: Container(
          height: 165,
          child: Center(
            child: FutureBuilder(
                future: APIprovider().getMovieCrew(id: id),
                builder: (context, snapshot) {
                  //print(snapshot.data);
                  return snapshot.data == null
                      ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: white,
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (_, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snapshot.data[index].crewimage,
                                  width:
                                  MediaQuery.of(context).size.width /
                                      2 -
                                      20,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            snapshot.data[index].role,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                  );
                }),
          ),
        ),
      ),
    ]);
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description:",
            style: TextStyle(
                color: black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.movie.desc,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
