import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/services/apiProvider.dart';

import 'mainScreen.dart';
import 'movie_Details.dart';

class SearchResults extends StatefulWidget {
  final String searchItem;
  SearchResults({this.searchItem});
  @override
  _SearchResults createState() => _SearchResults();
}

class _SearchResults extends State<SearchResults> {
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
    //print(widget.searchItem);
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
              children: [
                Text(
                  'Search Results',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: APIprovider().searchList(widget.searchItem),
                    builder: (context, snapshot) {
                      //print(snapshot);
                      return snapshot.data == null || snapshot.data.length == 0
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: white,
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                padding: EdgeInsets.zero,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    snapshot.data.length != 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              MovieDetails(
                                                                authenticated:
                                                                    false,
                                                                movie: snapshot
                                                                        .data[
                                                                    index],
                                                                movieid: snapshot
                                                                    .data[index]
                                                                    .id,
                                                              )));
                                                },
                                                child: Padding(
                                                  padding: index % 2 == 0
                                                      ? EdgeInsets.only(
                                                          top: 2.0, right: 6)
                                                      : EdgeInsets.only(
                                                          top: 2.0, left: 6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      snapshot.data[index]
                                                          .bannerimage,
                                                      fit: BoxFit.fill,
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              20,
                                                      height: 115,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 1.0,
                                                    left:
                                                        index % 2 == 0 ? 2 : 9),
                                                child: Text(
                                                  snapshot.data[index].title,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.0,
                                                    left:
                                                        index % 2 == 0 ? 2 : 9,
                                                    right:
                                                        index % 2 == 0 ? 9 : 2),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data[index].language,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    // Text(
                                                    //   "Rs.${snapshot.data[index].price}",
                                                    //   style: TextStyle(fontSize: 12),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          )
                                        : Center(
                                            child: Container(
                                              child: Text("No Result Foud"),
                                            ),
                                          ),
                              ),
                            );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
