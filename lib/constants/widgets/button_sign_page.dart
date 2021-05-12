import 'package:flutter/material.dart';

import '../colors.dart';

Widget button(BuildContext context, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    child: OutlineButton(
      borderSide: BorderSide(color: blueColor),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(7.0)),
      child: Text(
        text,
        style: TextStyle(color: blueColor, fontSize: 15),
      ),
      onPressed: onTap,
    ),
  );
}
