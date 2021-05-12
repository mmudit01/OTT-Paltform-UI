import 'package:flutter/material.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/movies_list.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import "dart:math";

class Pages extends StatefulWidget {
  final String type;
  Pages({this.type});
  @override
  _Pagestate createState() => _Pagestate();
}

class _Pagestate extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 170;
    var _aspectRatio = _width / cellHeight;

    return Scaffold(
      backgroundColor: white,
      appBar: logoappBar(),
      drawer: Mydrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.type,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: orangeColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/filter_icon.png",
                            width: 10,
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Filter"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (_aspectRatio),
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) => thumbnail(index),
                itemCount: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget thumbnail(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: index % 2 == 0
              ? EdgeInsets.only(top: 8.0, right: 6)
              : EdgeInsets.only(top: 8.0, left: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              moviePic[Random().nextInt(moviePic.length)],
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0, left: index % 2 == 0 ? 2 : 9),
          child: Text(
            "Agneepath",
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 5.0,
              left: index % 2 == 0 ? 2 : 9,
              right: index % 2 == 0 ? 9 : 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hindi",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "Rs.450",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
