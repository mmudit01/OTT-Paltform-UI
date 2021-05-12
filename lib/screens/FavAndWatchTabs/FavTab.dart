import 'package:flutter/material.dart';
import 'package:shott_app/screens/FavAndWatchTabs/FavMovies.dart';
import 'package:shott_app/screens/FavAndWatchTabs/FavTvshow.dart';

class FavTab extends StatefulWidget {
  @override
  _FavAndWatchTabState createState() => _FavAndWatchTabState();
}

class _FavAndWatchTabState extends State<FavTab> with SingleTickerProviderStateMixin{
  TabController _controller;
  Color a = Colors.grey;
  Color b = Colors.grey;
  Color c = Colors.grey;
  Color d = Colors.grey;
  int c1 = 0;

  handlecle() {
    setState(() {
      if (_controller.index == 0) {
        a = Colors.red;
        b = Colors.grey;
        c = Colors.grey;
        d = Colors.grey;
      } else if (_controller.index == 1) {
        a = Colors.grey;
        b = Colors.red;
        c = Colors.grey;
        d = Colors.grey;
      } else if (_controller.index == 2) {
        a = Colors.grey;
        b = Colors.grey;
        c = Colors.red;
        d = Colors.grey;
      } else if (_controller.index == 3) {
        a = Colors.grey;
        b = Colors.grey;
        c = Colors.grey;
        d = Colors.red;
      }
    });
  }



  void initState() {
    super.initState();


    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _controller.addListener(handlecle());






  }


  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [FavMovies(),FavTvShow()],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          height: 60,
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.orangeAccent,
            indicatorColor: Colors.transparent,
            isScrollable: false,
            labelStyle: TextStyle(fontSize: 12),
            controller: _controller,
            tabs: [

              Tab(
                iconMargin: EdgeInsets.only(bottom: 3),
                icon: Icon(Icons.movie, size: 30, color: handlecle()),
                text: "Movies",
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 3),
                icon: Icon(Icons.tv, size: 30, color: handlecle()),
                text: 'Tv Shows',
              ),

            ],
          ),
        ),
      );
  }
}
