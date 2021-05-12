import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DevelopmentScreen extends StatefulWidget {
  final title;
  DevelopmentScreen(this.title);
  @override
  _DevelopmentScreenState createState() => _DevelopmentScreenState();
}

class _DevelopmentScreenState extends State<DevelopmentScreen> {
  String title;
  @override
  Widget build(BuildContext context) {
    title = widget.title;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Image.asset("assets/close.png")),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.blue,
              fontFamily: "Harabara",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.blue),
      ),
      body: Center(
          child: Text(
        "Will be updated soon.......                    ",
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
