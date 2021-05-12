import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/screens/TvShows/TvDetails.dart';
import 'package:shott_app/services/apiProvider.dart';
import '../movie_Details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class CategoryTab extends StatefulWidget {
  final String category;

  CategoryTab({@required this.category});
  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  final controller = PageController(viewportFraction: 0.8, initialPage: 2);
  String userId;
  Future checkUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("userId") != null) {
      setState(() {
        userId = pref.getString("userId");
        print(userId);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    checkUserId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FutureBuilder(
                future: APIprovider().getAllBanner(),
                builder: (context, snapshot) {
                  return snapshot.data == null || snapshot.data.length == 0
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: white,
                          ),
                        )
                      : BannerWidget(snapshot: snapshot.data);
                }),
          ),
          widget.category == "Home"
              ? Container()
              : widget.category == "TV Shows"
                  ? tvShowsTab(context, "TV Shows")
                  : trendingVideos(context, "Trending",userId),
          widget.category != "TV Shows"
              ? latestVideos(context, "Latest",userId)
              : Container(),

          widget.category != "TV Shows" ? languages(context,userId) : Container(),
          widget.category != "TV Shows" && userId!=null
              ? continueWatching1(context, "Continue Watching",userId)
              : Container(),
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  final dynamic snapshot;

  BannerWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    List<dynamic> imageList = [];
    for (int i = 0; i < snapshot.length; i++) {
      imageList.add(
        Image.network(
          snapshot[i].bannerimage,
          fit: BoxFit.fill,
        ),
      );
    }

    return Column(children: [
      SizedBox(
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            images: imageList,
            showIndicator: false,
            borderRadius: false,
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
          ))
    ]);
  }
}

Widget trendingVideos(BuildContext context, String title,String userId) {
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
            onTap: () {
              Navigator.of(context).pushNamed("/trending");
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child: Container(
        height: 165,
        child: Center(
          child: FutureBuilder(
              future: APIprovider().getFourTrend(),
              builder: (context, snapshot) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () async {

                                  print(userId);
                                  int time;
                                  String id=snapshot.data[index].id;
                                  print(id);
                                  if(userId!=null) {
                                    var res = await http.get(
                                        Uri.encodeFull(
                                            'https://api.shott.tech/api/continueplaying/$id/$userId'));

                                    var data = json.decode(res.body);
                                    print(data
                                        .toString()
                                        .length);
                                    if (data
                                        .toString()
                                        .length == 2) {
                                      print("null");
                                      time = 0;
                                    } else {
                                      time = int.parse(data.toString());
                                      print(time);
                                    }
                                  }else{
                                    time=0;
                                  }

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MovieDetails(
                                        authenticated: false,
                                        movie: snapshot.data[index],
                                        movieid: snapshot.data[index].id,
                                        time: time,
                                      )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data[index].bannerimage,
                                      width: MediaQuery.of(context).size.width /
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(fontWeight: FontWeight.w400),
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

Widget latestVideos(BuildContext context, String title,String userId) {
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
            onTap: () {
              Navigator.of(context).pushNamed("/latestVideos");
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child: Container(
        height: 165,
        child: Center(
          child: FutureBuilder(
              future: APIprovider().getFourLatest(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  print(userId);
                                  int time;
                                  String id=snapshot.data[index].id;
                                  print(id);
                                  if(userId!=null) {
                                    var res = await http.get(
                                        Uri.encodeFull(
                                            'https://api.shott.tech/api/continueplaying/$id/$userId'));

                                    var data = json.decode(res.body);
                                    print(data
                                        .toString()
                                        .length);
                                    if (data
                                        .toString()
                                        .length == 2) {
                                      print("null");
                                      time = 0;
                                    } else {
                                      time = int.parse(data.toString());
                                      print(time);
                                    }
                                  }else{
                                    time=0;
                                  }

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MovieDetails(
                                            authenticated: false,
                                            movie: snapshot.data[index],
                                            movieid: snapshot.data[index].id,
                                        time: time,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data[index].bannerimage,
                                      width: MediaQuery.of(context).size.width /
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        itemCount: 4??snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                      );
              }),
        ),
      ),
    ),
  ]);
}

Widget categoryTab(BuildContext context, String title) {
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
            onTap: () {
              // Navigator.of(context).pushNamed("/trending");
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child: Container(
        height: 165,
        child: Center(
          child: FutureBuilder(
              future: APIprovider().getVideoByCategory(category: title),
              builder: (context, snapshot) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  //print(snapshot.data[index].id);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MovieDetails(
                                            authenticated: false,
                                            movie: snapshot.data[index],
                                            movieid: snapshot.data[index].id,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data[index].bannerimage,
                                      width: MediaQuery.of(context).size.width /
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(fontWeight: FontWeight.w400),
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

Widget languageTab(BuildContext context, String title,String userId) {
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
            onTap: () {
              // Navigator.of(context).pushNamed("/latestVideos");
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child: Container(
        height: 165,
        child: Center(
          child: FutureBuilder(
              future: APIprovider().getLanguages(category: title),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  print(userId);
                                  int time;
                                  String id=snapshot.data[index].id;
                                  print(id);
                                  if(userId!=null) {
                                    var res = await http.get(
                                        Uri.encodeFull(
                                            'https://api.shott.tech/api/continueplaying/$id/$userId'));

                                    var data = json.decode(res.body);
                                    print(data
                                        .toString()
                                        .length);
                                    if (data
                                        .toString()
                                        .length == 2) {
                                      print("null");
                                      time = 0;
                                    } else {
                                      time = int.parse(data.toString());
                                      print(time);
                                    }
                                  }else{
                                    time=0;
                                  }

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MovieDetails(
                                        authenticated: false,
                                        movie: snapshot.data[index],
                                        movieid: snapshot.data[index].id,
                                        time: time,
                                      )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data[index].bannerimage,
                                      width: MediaQuery.of(context).size.width /
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(fontWeight: FontWeight.w400),
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

Widget languages(BuildContext context,String user) {
  return FutureBuilder(
    future: APIprovider().getTotalLanguages(),
    builder: (context, snapshot) {
      print(snapshot.data);
      return snapshot.data == null || snapshot.data.length == 0
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: white,
              ),
            )
          : Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => languageTab(
                  context,
                  snapshot.data[index].toString(),user
                ),
              ),
            );
    },
  );
}


Widget continueWatching1(BuildContext context, String title,String userId) {
  return Column(children: [

    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child:  FutureBuilder(
              future: APIprovider().getContinueWatching(),
              builder: (context, snapshot) {
                print("working");
                return snapshot.data == null || snapshot.data.length == 0
                    ? Container()
                    : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/latestVideos");
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height:156,
                          child: Center(
                            child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (_, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    print(snapshot.data[index].bannerimage);
                                    print(snapshot.data[index].title);
                                    print(userId);
                                    int time;
                                    String id=snapshot.data[index].id;
                                    print(id);
                                    if(userId!=null) {
                                      var res = await http.get(
                                          Uri.encodeFull(
                                              'https://api.shott.tech/api/continueplaying/$id/$userId'));

                                      var data = json.decode(res.body);
                                      print(data
                                          .toString()
                                          .length);
                                      if (data
                                          .toString()
                                          .length == 2) {
                                        print("null");
                                        time = 0;
                                      } else {
                                        time = int.parse(data.toString());
                                        print(time);
                                      }
                                    }else{
                                      time=0;
                                    }

                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => MovieDetails(
                                          authenticated: false,
                                          movie: snapshot.data[index],
                                          movieid: snapshot.data[index].id,
                                          time: time,
                                        )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data[index].bannerimage,
                                        width: MediaQuery.of(context).size.width /
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data[index].title,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                  ),
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                ),
                          ),
                        ),
                      ],
                    );
              }),
        ),

  ]);
}


Widget continueWatching(BuildContext context, String title,String userId) {
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
            onTap: () {
              Navigator.of(context).pushNamed("/latestVideos");
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child: Container(
        height: 165,
        child: Center(
          child: FutureBuilder(
              future: APIprovider().getContinueWatching(),
              builder: (context, snapshot) {
                print("working");
                return snapshot.data == null || snapshot.data.length == 0
                    ? Text("Explore,Enjoy various Movies and Tv shows ",style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w600),)
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (_, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () async {
                            print(snapshot.data[index].bannerimage);
                            print(snapshot.data[index].title);
                            print(userId);
                            int time;
                            String id=snapshot.data[index].id;
                            print(id);
                            if(userId!=null) {
                              var res = await http.get(
                                  Uri.encodeFull(
                                      'https://api.shott.tech/api/continueplaying/$id/$userId'));

                              var data = json.decode(res.body);
                              print(data
                                  .toString()
                                  .length);
                              if (data
                                  .toString()
                                  .length == 2) {
                                print("null");
                                time = 0;
                              } else {
                                time = int.parse(data.toString());
                                print(time);
                              }
                            }else{
                              time=0;
                            }

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MovieDetails(
                                  authenticated: false,
                                  movie: snapshot.data[index],
                                  movieid: snapshot.data[index].id,
                                  time: time,
                                )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  snapshot.data[index].bannerimage,
                                width: MediaQuery.of(context).size.width /
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data[index].title,
                          style: TextStyle(fontWeight: FontWeight.w400),
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


Widget tvShowsTab(BuildContext context, String title) {
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
            onTap: () {
              Navigator.of(context).pushNamed("/tvShows");
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7, bottom: 7),
      child: Container(
        height: 165,
        child: Center(
          child: FutureBuilder(
              future: APIprovider().getTVShow(),
              builder: (context, snapshot) {
                //print(snapshot.data);
                return snapshot.data == null
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: white,
                        ),
                      )
                    :

                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      //print(snapshot.data[index].id);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => TvDetailsPage(
                                            tvShow: snapshot.data[index],
                                            authenticated: false,
                                            tvShowId: snapshot.data[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          snapshot.data[index].bannerimage,
                                          width: MediaQuery.of(context).size.width /
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            itemCount:
                                snapshot.data.length > 4 ? 4 : snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                          );

              }),
        ),
      ),
    ),
  ]);
}
