import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/screens/TvShows/TvDetails.dart';
import 'package:shott_app/screens/mainScreen.dart';
import 'package:shott_app/screens/movie_Details.dart';
import 'package:shott_app/services/apiProvider.dart';


class FavTvShow extends StatefulWidget {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();



  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<FavTvShow> {
  @override
  void initState() {
    checkUserId();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoappBar(),
      drawer: Mydrawer(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
               // favouriteMovies(context),
                // SizedBox(height: 30,),
                SizedBox(height: 15,),
                favouriteTvShows(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget favouriteTvShows(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tv Show',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        FutureBuilder(
          future: APIprovider().getFavouriteTv(userId),
          builder: (context, snapshot) {
            print(snapshot);
            return snapshot.data == null || snapshot.data.length == 0
                ? Center(
              child:Image.asset(
                "assets/empty.gif",
                height: 500.0,
                width: 500.0,
                fit: BoxFit.cover,
              ),
            )
                : Container(
              // height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //print(snapshot.data[index].id);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => TvDetailsPage(
                                  authenticated: false,
                                  tvShow:  snapshot.data[index],
                                  tvShowId: snapshot.data[index].id,
                                )));
                          },
                          child: Padding(
                            padding: index % 2 == 0
                                ? EdgeInsets.only(top: 1.0, right: 6)
                                : EdgeInsets.only(top: 1.0, left: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data[index].bannerimage,
                                width: 500,
                                height: 115,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.0, left: index % 2 == 0 ? 2 : 9),
                          child: Text(
                            snapshot.data[index].title,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 1.0,
                              left: index % 2 == 0 ? 2 : 9,
                              right: index % 2 == 0 ? 9 : 2),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data[index].language,
                                style: TextStyle(fontSize: 12),
                              ),
                              // Text(
                              //   "Rs.${snapshot.data[index].price}",
                              //   style: TextStyle(fontSize: 12),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          height: 28,
                          child: TextButton(
                              child: Text("Remove from list".toUpperCase(),
                                  style: TextStyle(fontSize: 9)),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsets>(EdgeInsets.all(8)),
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.orangeAccent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(1.0),
                                          side: BorderSide(color: Colors.orangeAccent)))),
                              onPressed: () async {
                                String id = snapshot.data[index].id;
                                //print(id);
                                //print(userId);
                                //print("tap");
                                var res = await http.post(
                                    Uri.encodeFull(
                                        'https://api.shott.tech/api/removefavioret_tv/$id'),
                                    headers: {
                                      "Accept": "application/json"
                                    },
                                    body: {
                                      "_id": userId,
                                    });
                                setState(() {});
                                print(res.body);
                                //print(id);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget favouriteMovies(BuildContext context) {
    return Column(
      children: [
        Text(
          'Movies',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        FutureBuilder(
          future: APIprovider().getFavourite(userId),
          builder: (context, snapshot) {
            //print(snapshot);
            return snapshot.data == null || snapshot.data.length == 0
                ? Center(
              child: Text(
                "You haven't added any movie to Favorites",
              ),
            )
                : Container(

              child: GridView.builder(

                itemCount: snapshot.data.length,
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
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
                            padding: index % 2 == 0
                                ? EdgeInsets.only(top: 1.0, right: 6)
                                : EdgeInsets.only(top: 1.0, left: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data[index].bannerimage,
                                height: 115,
                                width: 500,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.0, left: index % 2 == 0 ? 2 : 9),
                          child: Text(
                            snapshot.data[index].title,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 1.0,
                              left: index % 2 == 0 ? 2 : 9,
                              right: index % 2 == 0 ? 9 : 2),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data[index].language,
                                style: TextStyle(fontSize: 12),
                              ),
                              // Text(
                              //   "Rs.${snapshot.data[index].price}",
                              //   style: TextStyle(fontSize: 12),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          height: 28,
                          child: TextButton(
                              child: Text("Remove from list".toUpperCase(),
                                  style: TextStyle(fontSize: 9)),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsets>(EdgeInsets.all(8)),
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.orangeAccent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(1.0),
                                          side: BorderSide(color: Colors.orangeAccent)))),
                              onPressed: () async {
                                String id = snapshot.data[index].id;
                                //print(id);
                                //print(userId);
                                //print("tap");
                                var res = await http.post(
                                    Uri.encodeFull(
                                        'https://api.shott.tech/api/removefavioret/$id'),
                                    headers: {
                                      "Accept": "application/json"
                                    },
                                    body: {
                                      "_id": userId,
                                    });
                                setState(() {

                                });

                                //print(res.body);
                                //print(id);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
