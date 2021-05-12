import 'package:flutter/material.dart';

import '../colors.dart';

AppBar logoappBar() {
  return AppBar(
    backgroundColor: white,
    centerTitle: true,
    elevation: 0,
    title: Container(
      child: Image.asset(
        "assets/shott_logo.png",
        height: 50.0,
        width: 70.0,
        alignment: Alignment.center,
      ),
    ),


    iconTheme: IconThemeData(color: orangeColor),
  );
}
