import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/models/Banner.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/screens/GetMoviesByGenre.dart';
import 'package:shott_app/services/apiProvider.dart';

import 'mainScreen.dart';

class Genre extends StatefulWidget {
  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  void initState() {
    super.initState();
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
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder(
                    future: APIprovider().getAllCategories(),
                    builder: (context, snapshot) {
                      //print(snapshot);
                      return snapshot.data == null || snapshot.data.length == 0
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: white,
                              ),
                            )
                          : GridView.builder(
                              itemCount: snapshot.data.length,
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  //print("tap");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => GetGenre(
                                          name: snapshot.data[index].name)));
                                },
                                child: Padding(
                                  padding: index % 2 == 0
                                      ? EdgeInsets.only(
                                          top: 10, bottom: 8, right: 8)
                                      : EdgeInsets.only(
                                          top: 10, bottom: 8, left: 8),
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //print("tap");
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetGenre(
                                                          name: snapshot
                                                              .data[index]
                                                              .name)));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              30,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              10,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              child: Image.network(
                                                snapshot.data[index].image,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                30,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black54,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
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
