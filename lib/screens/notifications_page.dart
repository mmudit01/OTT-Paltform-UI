

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';


class NotificationsPage extends StatefulWidget {
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {

  var fetchedData = null;

  ScrollController scrollController = ScrollController();
  void initState(){

    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: logoappBar(),
      drawer: Mydrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Notification',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //cart items list
                        showfeedback(),

                        showfeedback(),
                        showfeedback1(),
                        showfeedback1(),
                        showfeedback1(),

                      ],
                    ),
                  ),
                ),
              ])),
        ),
      );
  }



  Widget showfeedback(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text(
                  'Movie Alert! Stay Tuned...',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,color: Colors.redAccent[100])),
                  Text(
                      '3 May 2021',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,color: Colors.redAccent[100])),
            ]),
          ),
          Padding(
            padding:const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width/1.3,
                    child: Text(

                        'Agneepath - An opacity of 0.0 means no opacity, that is, it’s completely transparent. If you wanted to make it completely opaque (that is, no transparency), you would set the opacity to 1.0. ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,color: Colors.redAccent[100]),maxLines: 4,),
                  ),
                ]),
          ),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(
                    color: Colors.grey[400],
                    height: 15,
                  )),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(

                    'Viewed By ***',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,color: Colors.redAccent[100]),maxLines: 4,),
                  Icon(Icons.remove_red_eye_rounded,size: 15,color: Colors.redAccent[100],),
                ]),
          ),
        ],
      ),
    );
  }
  Widget showfeedback1(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Movie Alert! Stay Tuned...',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,color: Colors.grey)),
                  Text(
                      '3 May 2021',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,color: Colors.grey)),
                ]),
          ),
          Padding(
            padding:const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width/1.3,
                    child: Text(

                      'Agneepath - An opacity of 0.0 means no opacity, that is, it’s completely transparent. If you wanted to make it completely opaque (that is, no transparency), you would set the opacity to 1.0. ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,color: Colors.grey),maxLines: 4,),
                  ),
                ]),
          ),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(
                    color: Colors.grey[400],
                    height: 15,
                  )),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(

                    'Viewed By ***',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,color: Colors.grey),maxLines: 4,),
                  Icon(Icons.remove_red_eye_rounded,size: 15,color: Colors.grey,),
                ]),
          ),
        ],
      ),
    );
  }
}
