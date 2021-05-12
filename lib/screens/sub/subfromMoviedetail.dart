import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/services/apiProvider.dart';
import 'package:shott_app/services/stripe.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import '../mainScreen.dart';

class subMovied extends StatefulWidget {
  final Movie movie;

  subMovied({this.movie});
  @override
  _subDrawerState createState() => _subDrawerState();
}

class _subDrawerState extends State<subMovied> {
  String _error;
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  @override
  void initState() {
    super.initState();
    checkUserAuthenticate();
    checkUserId();
    checkUserSub();
    checkEmail();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IX1o4SB0gSsu8cg4mxASlX5BgEFJO7NYfVbNHnfRHmps8tOzn8XoP14yl894TJv3vC2pxSRSduMaE5gzo2XRxLW00gYpG8hHv",
        merchantId: "",
        androidPayMode: "test"));
  }

  String email;
  Future checkEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("email") != null) {
      setState(() {
        email = pref.getString("email");
        print(email);
      });
    }
  }

  bool authenticate;
  Future checkUserAuthenticate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("authenticated") != null) {
      setState(() {
        authenticate = pref.getBool("authenticated");
        //print(authenticate);
      });
    }
  }

  void setError(dynamic error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // ignore: deprecated_member_use
    // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
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

  String sub;
  Future checkUserSub() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("sub") != null) {
      setState(() {
        sub = pref.getString("sub");
        //print(sub);
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Subscription',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 12,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              decoration:
                                  BoxDecoration(color: Color(0xffFF9900)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: Text(
                                "1 Month",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Rs." + "  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(
                                    "1" + "/-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 25,
                            // ),
                            // Container(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Text(
                            //         "Unlimited Telugu Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited English Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited Bollywood Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () async {
                                var response =
                                    await StripeService.payWithNewCard(
                                  amount: "100",
                                  currency: 'INR',
                                );
                                print(response.message);
                                print(response.paymentid);
                                if (response.message ==
                                    "Transaction successful") {
                                  final uri =
                                      "https://api.shott.tech/api/stripepaymentmobile";
                                  final headers = {
                                    'Content-Type':
                                        'application/x-www-form-urlencoded'
                                  }; //if required
                                  print(userId.toString());
                                  Response getResponse =
                                      await post(uri, headers: headers, body: {
                                    "receipt_email": email,
                                    // "source":response.paymentid,
                                    "userid": userId.toString(),
                                    "amount": "1",
                                    //"plan":"1",
                                    "paymentid": response.paymentid,
                                    "duration": "180"
                                  });
                                  String responseBody = getResponse.body;
                                  var data = json.decode(responseBody);
                                  print(data);
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("sub", "yes");
                                  String startDate =  data["startdate"] ?? "NA";
                                  String enddate = data["enddate"] ?? "NA";
                                  int price=data["price"];
                                  pref.setInt("price", price);
                                  pref.setString("sd", startDate);
                                  pref.setString("ed", enddate);

                                  print(response.message);
                                  Fluttertoast.showToast(
                                      msg:
                                          "Your subscription for 1 Months has started.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  String i = widget.movie.id;
                                  String link = widget.movie.video;
                                  Navigator.of(context).pushReplacementNamed(
                                      "/playVideo",
                                      arguments: link);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff217BEF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'Subscribe Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )

                    // SubscriptionBox(
                    //   duration: item.toString(),
                    //   price: price[item].toString(),
                    // ),
                    ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 12,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              decoration:
                                  BoxDecoration(color: Color(0xffFF9900)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: Text(
                                "3 Months",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Rs." + "  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(
                                    "3" + "/-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 25,
                            // ),
                            // Container(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Text(
                            //         "Unlimited Telugu Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited English Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited Bollywood Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () async {
                                var response =
                                    await StripeService.payWithNewCard(
                                  amount: "600",
                                  currency: 'INR',
                                );
                                print(response.message);
                                print(response.paymentid);
                                if (response.message ==
                                    "Transaction successful") {
                                  final uri =
                                      "https://api.shott.tech/api/stripepaymentmobile";
                                  final headers = {
                                    'Content-Type':
                                        'application/x-www-form-urlencoded'
                                  }; //if required
                                  print(userId.toString());
                                  Response getResponse =
                                      await post(uri, headers: headers, body: {
                                    "receipt_email": email,
                                    // "source":response.paymentid,
                                    "userid": userId.toString(),
                                    "amount": "3",
                                    //"plan":"1",
                                    "paymentid": response.paymentid,
                                    "duration": "180"
                                  });
                                  String responseBody = getResponse.body;
                                  var data = json.decode(responseBody);
                                  print(data);
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("sub", "yes");
                                  String startDate =  data["startdate"] ?? "NA";
                                  String enddate = data["enddate"] ?? "NA";
                                  int price=data["price"];
                                  pref.setInt("price", price);
                                  pref.setString("sd", startDate);
                                  pref.setString("ed", enddate);

                                  print(response.message);
                                  Fluttertoast.showToast(
                                      msg:
                                          "Your subscription for 3 Months has started.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  String i = widget.movie.id;
                                  String link = widget.movie.video;
                                  Navigator.of(context).pushReplacementNamed(
                                      "/playVideo",
                                      arguments: link);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff217BEF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'Subscribe Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )

                    // SubscriptionBox(
                    //   duration: item.toString(),
                    //   price: price[item].toString(),
                    // ),
                    ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 12,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              decoration:
                                  BoxDecoration(color: Color(0xffFF9900)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: Text(
                                "6 Months",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Rs." + "  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(
                                    "6" + "/-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 25,
                            // ),
                            // Container(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Text(
                            //         "Unlimited Telugu Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited English Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited Bollywood Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () async {
                                var response =
                                    await StripeService.payWithNewCard(
                                  amount: "900",
                                  currency: 'INR',
                                );
                                print(response.message);
                                print(response.paymentid);
                                if (response.message ==
                                    "Transaction successful") {
                                  final uri =
                                      "https://api.shott.tech/api/stripepaymentmobile";
                                  final headers = {
                                    'Content-Type':
                                        'application/x-www-form-urlencoded'
                                  }; //if required
                                  print(userId.toString());
                                  Response getResponse =
                                      await post(uri, headers: headers, body: {
                                    "receipt_email": email,
                                    // "source":response.paymentid,
                                    "userid": userId.toString(),
                                    "amount": "9",
                                    //"plan":"1",
                                    "paymentid": response.paymentid,
                                    "duration": "180"
                                  });
                                  String responseBody = getResponse.body;
                                  var data = json.decode(responseBody);
                                  print(data);
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("sub", "yes");
                                  String startDate =  data["startdate"] ?? "NA";
                                  String enddate = data["enddate"] ?? "NA";
                                  int price=data["price"];
                                  pref.setInt("price", price);
                                  pref.setString("sd", startDate);
                                  pref.setString("ed", enddate);

                                  print(response.message);
                                  Fluttertoast.showToast(
                                      msg:
                                          "Your subscription for 6 Months has started.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  String i = widget.movie.id;
                                  String link = widget.movie.video;
                                  Navigator.of(context).pushReplacementNamed(
                                      "/playVideo",
                                      arguments: link);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff217BEF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'Subscribe Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )

                    // SubscriptionBox(
                    //   duration: item.toString(),
                    //   price: price[item].toString(),
                    // ),
                    ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 12,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              decoration:
                                  BoxDecoration(color: Color(0xffFF9900)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: Text(
                                "1 Year",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Rs." + "  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(
                                    "12" + "/-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 25,
                            // ),
                            // Container(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Text(
                            //         "Unlimited Telugu Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited English Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 9,
                            //       ),
                            //       Text(
                            //         "Unlimited Bollywood Movies and Shows",
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.w700,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () async {
                                var response =
                                    await StripeService.payWithNewCard(
                                  amount: "1200",
                                  currency: 'INR',
                                );
                                print(response.message);
                                print(response.paymentid);
                                if (response.message ==
                                    "Transaction successful") {
                                  final uri =
                                      "https://api.shott.tech/api/stripepaymentmobile";
                                  final headers = {
                                    'Content-Type':
                                        'application/x-www-form-urlencoded'
                                  }; //if required
                                  print(userId.toString());
                                  Response getResponse =
                                      await post(uri, headers: headers, body: {
                                    "receipt_email": email,
                                    // "source":response.paymentid,
                                    "userid": userId.toString(),
                                    "amount": "12",
                                    //"plan":"1",
                                    "paymentid": response.paymentid,
                                    "duration": "180"
                                  });
                                  String responseBody = getResponse.body;
                                  var data = json.decode(responseBody);
                                  print(data);
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("sub", "yes");
                                  String startDate =  data["startdate"] ?? "NA";
                                  String enddate = data["enddate"] ?? "NA";
                                  int price=data["price"];
                                  pref.setInt("price", price);
                                  pref.setString("sd", startDate);
                                  pref.setString("ed", enddate);

                                  print(response.message);
                                  Fluttertoast.showToast(
                                      msg:
                                          "Your subscription for 1 year has started.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  String i = widget.movie.id;
                                  String link = widget.movie.video;
                                  Navigator.of(context).pushReplacementNamed(
                                      "/playVideo",
                                      arguments: link);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff217BEF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'Subscribe Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )

                    // SubscriptionBox(
                    //   duration: item.toString(),
                    //   price: price[item].toString(),
                    // ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
