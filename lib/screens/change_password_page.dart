import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';

import 'mainScreen.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _cPasswordcontroller = TextEditingController();
  final TextEditingController _nPasswordcontroller = TextEditingController();
  final TextEditingController _rPasswordcontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String cPass;
  String nPass;
  String rPass;
  String username;

  void initState() {
    super.initState();

    checkname5();
    // updatePass();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // Future<UserModel> updatePass() async{
  //   final http.Response response = await http.post(
  //       Settings.SERVER_URL + 'api/changepass.php',
  //       body: {"username": username,"oldpass":cPass ,"newpass": rPass}
  //     //headers: {'Content-Type': 'application/json'},
  //   );
  //   final responseData = json.decode(response.body.toString());
  //   print(response.statusCode);
  //   print(response.body);
  // }

  Future checkname5() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("username") != null) {
      setState(() {
        username = pref.getString("username");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget changePasswordButton = InkWell(
      onTap: () async {
        // cPass = _cPasswordcontroller.text;
        // nPass = _nPasswordcontroller.text;
        // rPass = _rPasswordcontroller.text;
        // final http.Response response = await http.post(
        //     Settings.SERVER_URL + 'api/changepass.php',
        //     body: {"username": username,"oldpass":cPass ,"newpass": rPass}
        //   //headers: {'Content-Type': 'application/json'},
        // );
        // final responseData = json.decode(response.body.toString());
        // print(response.statusCode);
        // print(response.body);
        //
        // setState(()  {
        //   _form.currentState.validate();
        //
        // });
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: new Text(responseData["errmsg"]),
        //       actions: <Widget>[
        //         FlatButton(
        //           child: new Text("OK"),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      },
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            color: purpleColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Confirm Change",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: logoappBar(),
      drawer: Mydrawer(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          return false;


        },
        child: SafeArea(
            bottom: true,
            child: LayoutBuilder(
              builder: (b, constraints) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 48.0, top: 16.0),
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                'Enter your current password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Form(
                              key: _form,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: TextFormField(
                                    controller: _cPasswordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Existing Password',
                                        hintStyle: TextStyle(fontSize: 12.0)),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 12.0),
                              child: Text(
                                'Enter new password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                    controller: _nPasswordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'New Password',
                                        hintStyle: TextStyle(fontSize: 12.0)),
                                    validator: (val) {
                                      if (val.isEmpty) return 'Empty';
                                      return null;
                                    })),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 12.0),
                              child: Text(
                                'Retype new password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                    controller: _rPasswordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Retype Password',
                                        hintStyle: TextStyle(fontSize: 12.0)),
                                    validator: (val) {
                                      if (val.isEmpty) return 'Empty';
                                      if (val != _nPasswordcontroller.text)
                                        return 'Not Match';
                                      return null;
                                    })),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: bottomPadding != 20 ? 20 : bottomPadding),
                            width: width,
                            child: Center(child: changePasswordButton),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
