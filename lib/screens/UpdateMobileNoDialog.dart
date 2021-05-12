import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/screens/mainScreen.dart';
import 'package:shott_app/screens/profile_screen.dart';

class UpdateNoDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<UpdateNoDialog> {
  final TextEditingController _Reviewcontroller = TextEditingController();
  String id;
  @override
  void initState() {
    checkname();
    super.initState();
  }

  Future checkname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("userId") != null) {
      setState(() {
        id = pref.getString("userId");
        //print(id);
      });
    }
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // locator<ConnectivityManager>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget payNow = InkWell(
      onTap: () async {
        final String _baseUrl = "https://api.shott.tech/api/";
        String link = _baseUrl + "updateuser/$id";
        var res = await http.post(Uri.encodeFull(link),
            headers: {"Accept": "application/json"},
            body: {"mobilenumber": _Reviewcontroller.text});
        if (res.statusCode == 200) {
          var data = json.decode(res.body);
          //print(data);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          int mobile = data["mobilenumber"];
          prefs.setInt("mobileNo", mobile ?? 0);
          //print(mobile);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfilePage()));
        }
      },
      child: Container(
        height: 60,
        width: width / 1.5,
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Confirm",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[50]),
          padding: EdgeInsets.all(24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RichText(
                text: TextSpan(
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                    children: [
                      TextSpan(
                          text: "Update Phone Number",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ]),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextFormField(
                  controller: _Reviewcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Enter new Contact Number'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLength: 10,
                )),
            payNow
          ])),
    );
  }
}
