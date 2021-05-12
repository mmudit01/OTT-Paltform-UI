import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/models/Banner.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/services/apiProvider.dart';

class GetGenre extends StatefulWidget {
  final String name;
  GetGenre({this.name});

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<GetGenre> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                  future: APIprovider().getMoviesByGenre(widget.name),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: index % 2 == 0
                                          ? EdgeInsets.only(top: 8.0, right: 6)
                                          : EdgeInsets.only(top: 8.0, left: 6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          snapshot.data[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.0,
                                          left: index % 2 == 0 ? 2 : 9),
                                      child: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.0,
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
                                          Text(
                                            "Rs.${snapshot.data[index].price}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
