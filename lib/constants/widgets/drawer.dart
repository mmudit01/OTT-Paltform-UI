import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/screens/notifications_page.dart';
import 'package:shott_app/services/apiProvider.dart';

import '../colors.dart';

class Mydrawer extends StatefulWidget {
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<Mydrawer> {
  bool authenticate;
  Future checkUserAuthenticate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("authenticated") != null) {
      setState(() {
        authenticate = pref.getBool("authenticated");
        // print(authenticate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserAuthenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      child: Drawer(
          child: (authenticate == true)
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [
                        // Color.fromRGBO(14, 4, 23, 1),
                        // Color.fromRGBO(55, 19, 82, 1),
                        // Color.fromRGBO(63, 14, 56, 1),
                        // Color.fromRGBO(59, 21, 78, 1),
                        Color(0xff3c0d56),
                        Color(0xff450638),
                        Color(0xff3d115c),
                      ],
                    ),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        height: 100,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: purpleColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/shott_logo.png",
                                width: 70,
                                alignment: Alignment.centerLeft,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsPage()));
                                    },
                                    child: Container(
                                        child: Icon(Icons.notifications,color: Colors.orangeAccent,)
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Image.asset(
                                        "assets/close_icon.png",
                                        width: 18,
                                        height: 18,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                      listile(context, "Home", "recomonded", "/"),
                      //  listile(context, "Genre", "categories", "/Categories"),
                      listile(context, "Favorites", "favorite", "/Favorites"),
                      listile(context, "Watchlist", "watching", '/To Watch'),
                      listile(context, "Subscription", "subscrption",
                          '/subscription'),
                      //  listile(context, "Order History", "order_history",
                      //    ''),
                      listile(context, "Viewing History", "viewing_history",
                          '/history'),
                      listile(context, "Profile", "profile", '/profile'),
                      // listile(context, "Change Password", "change_password",
                      //     '/changePassword'),
                      listile(context, "Logout", "logout", '/signOut'),
                      SearchFiled(),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [
                        // Color.fromRGBO(14, 4, 23, 1),
                        // Color.fromRGBO(55, 19, 82, 1),
                        // Color.fromRGBO(63, 14, 56, 1),
                        // Color.fromRGBO(59, 21, 78, 1),
                        Color(0xff3c0d56),
                        Color(0xff450638),
                        Color(0xff3d115c),
                      ],
                    ),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        height: 100,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: purpleColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/shott_logo.png",
                                width: 70,
                                alignment: Alignment.centerLeft,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsPage()));
                                    },
                                    child: Container(
                                        child: Icon(Icons.notifications,color: Colors.orangeAccent,)
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Image.asset(
                                        "assets/close_icon.png",
                                        width: 18,
                                        height: 18,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      listile(context, "Home", "recomonded", "/"),
                      // listile(context, "Genre", "categories", "/Categories"),
                      // listile(context, "Favorites", "favorite", "/Favorites"),
                      // listile(context, "To Watch", "watching", '/To Watch'),
                      listile(context, "Subscription", "subscrption",
                          '/subscription'),
                      // listile(context, "Order History", "order_history",
                      //     '/history'),
                      // listile(context, "Viewing History", "viewing_history",
                      //     '/underDevelopment'),
                      // listile(context, "Profile", "profile", '/profile'),
                      // listile(context, "Change Password", "change_password",
                      //     '/changePassword'),
                      listile(context, "LogIn", "logout", '/signindrawer'),

                      SearchFiled(),
                    ],
                  ),
                )),
    );
  }
}

class SearchFiled extends StatelessWidget {
  const SearchFiled({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String search;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff692668),
        ),
        color: Color(0xff4C154C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (value) {
          search = value;
          //print(search);
        },
        onSubmitted: (value) async {
          Navigator.of(context).pushNamed("/search_result", arguments: search);
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            15,
          ),
          hintText: "Search For ...",
          hintStyle: TextStyle(
            color: Color(0xff775A7A),
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              Navigator.of(context)
                  .pushNamed("/search_result", arguments: search);
            },
            icon: Icon(
              Icons.search,
            ),
            color: Colors.white,
          ),
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}

Widget listile(BuildContext context, String title, String file, String route) {
  String _route = route;
  String _title = title;
  return Container(
    height: 38,
    child: Center(
      child: ListTile(
        onTap: () {
          Navigator.pushReplacementNamed(context, _route, arguments: _title);
        },
        leading: Image.asset(
          "assets/drawer/${file}_icon.png",
          width: 21,
        ),
        title: Align(
          alignment: Alignment(-1, 0),
          child: Text(
            title,
            style: TextStyle(color: white),
          ),
        ),
        subtitle: Text(""),
      ),
    ),
  );
}
