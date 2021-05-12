import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/screens/UpdateMobileNoDialog.dart';

import 'mainScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<ProfilePage> {
  ScrollController scrollController = ScrollController();
  ScrollPhysics physics = ScrollPhysics();
  String username;

  String email;
  SharedPreferences pref;

////////
  String type;
  String phone;

  File _userImageFile = File('');
  String _userImageUrlFromFB = '';
  File image;
  int mobileNo;
  String sd;
  String ed;
/////

  @override
  void initState() {
    //locator<ConnectivityManager>().initConnectivity(context);

    checkname();
    checkEmail();
    checkLoginType();
    checkMobile();
    checkenddate();
    checkstartDate();
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // locator<ConnectivityManager>().dispose();
  }

  Future checkname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("name") != null) {
      setState(() {
        username = pref.getString("name");
        //print(username);
      });
    }
  }

  Future checkMobile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("mobileNo") != null) {
      setState(() {
        mobileNo = pref.getInt("mobileNo");
        //print(mobileNo.toString());
      });
    }
  }

  Future checkstartDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("sd") != null) {
      setState(() {
        sd = pref.getString("sd");
        //print(sd);
      });
    }
  }

  Future checkenddate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("ed") != null) {
      setState(() {
        ed = pref.getString("ed");
        //print(ed);
      });
    }
  }

  Future checkEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("email") != null) {
      setState(() {
        email = pref.getString("email");
        //print(email);
      });
    }
  }

  Future checkPhoneNo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("phoneno") != null) {
      setState(() {
        phone = pref.getString("phoneno");
        //print(phone);
      });
    }
  }

  Future checkLoginType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("type") != null) {
      setState(() {
        type = pref.getString("type");
        //print(type);
      });
    }
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
            child:
                profileView()) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Center(
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            buildTextField("Full Name", username, false),
            buildTextField("E-mail", email, false),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile No",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  TextField(
                    enabled: true,
                    showCursor: true,
                    readOnly: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: mobileNo == null ? "NA" : mobileNo.toString(),
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      suffixIcon: IconButton(
                        onPressed: () {
                          //print("hi");
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: UpdateNoDialog(),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildTextField("Login Type", type, false),
            sd != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Text(
                            "Subscription",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
                        child: Text(
                          sd == null ? "Start Date :NA" : "Start Date :$sd",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text(
                          ed == null ? "End Date :NA" : "End Date :$ed" ?? "--",
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        enabled: false,
        // obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      //print("tap");
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
