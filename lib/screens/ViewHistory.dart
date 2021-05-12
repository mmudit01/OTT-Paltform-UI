import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/services/apiProvider.dart';

import 'mainScreen.dart';

class History extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<History> {
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
    checkUserId();
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

  String userId;
  Future checkUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("userId") != null) {
      setState(() {
        userId = pref.getString("userId");
        //print(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: logoappBar(),
      drawer: Mydrawer(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          return false;
        },
        child: SafeArea(
            bottom: true,
            child: LayoutBuilder(
              builder: (b, constraints) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20.0, top: 16.0),
                              child: Text(
                                'Viewing History',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),

                            Table(
                                border: TableBorder
                                    .all(), // Allows to add a border decoration around your table
                                children: [
                                  TableRow(
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                      children: [
                                        Text('Movie Title'),
                                      ]),
                                ]),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder(
                                future: APIprovider().getViewHistory(userId),
                                builder: (context, snapshot) {
                                  //print(snapshot);
                                  return snapshot.data == null ||
                                          snapshot.data.length == 0
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: white,
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: snapshot.data.length,
                                          padding: EdgeInsets.zero,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            height: 19,
                                            child: Table(
                                                border: TableBorder
                                                    .all(), // Allows to add a border decoration around your table
                                                children: [
                                                  TableRow(children: [
                                                    Text(snapshot
                                                        .data[index].title),
                                                  ]),
                                                ]),
                                          ),
                                        );
                                }),
                            // Table(
                            //
                            //     border: TableBorder.all(), // Allows to add a border decoration around your table
                            //     children: [
                            //       TableRow(decoration: BoxDecoration(color: Colors.grey),children :[
                            //         Text("S.No"),
                            //         Text('Video Title'),
                            //         Text("Price"),
                            //         Text('Order Date'),
                            //         Text('Action'),
                            //       ]),
                            //       TableRow(children :[
                            //         Text('2011',),
                            //         Text('Dart'),
                            //         Text('Lars Bak'),
                            //         Text('Lars Bak'),
                            //         ElevatedButton(
                            //             child: Text(
                            //                 "View".toUpperCase(),
                            //                 style: TextStyle(fontSize: 14)
                            //             ),
                            //             style: ButtonStyle(
                            //                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            //                     RoundedRectangleBorder(
                            //                         borderRadius: BorderRadius.zero,
                            //                         side: BorderSide(color: Colors.blue)
                            //                     )
                            //                 )
                            //             ),
                            //             onPressed: () => null
                            //         )
                            //       ]),
                            //       TableRow(children :[
                            //         Text('1996'),
                            //         Text('Java'),
                            //         Text('James Gosling'),
                            //         Text('Lars Bak'),
                            //         Text('Lars Bak'),
                            //       ]),
                            //     ]
                            // ),
                          ],
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
