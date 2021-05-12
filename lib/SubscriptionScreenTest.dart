import 'package:flutter/material.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/screens/LoginSignupFromDrawer/signUp_page.dart';
import 'package:shott_app/services/stripe.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';
import 'package:shott_app/services/apiProvider.dart';

class SubscriptionTest extends StatefulWidget {
  @override
  _SubscriptionTestState createState() => _SubscriptionTestState();
}

class _SubscriptionTestState extends State<SubscriptionTest> {
  List<Widget> subscribeTab = [];
  Future getAllCategories() async {
    List<String> duration = [];
    Map<String, String> price = {};

    Map<String, dynamic> list = await APIprovider().subscription();
    price = list['price'];
    duration = list["duration"];
    Map<String, String> durations_printing = {
      "one_monthprice": "2 Month",
      "one_yearprice": "1 year",
      "six_monthprice": "6 Months",
      "three_monthprice": "3 Months",
    };

    for (var item in duration) {
      print(item);
      print(durations_printing[item].toString());
      print(price[item].toString());
      subscribeTab.add(
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 12,
          ),
          child: SubscriptionBox(
            duration: durations_printing[item].toString(),
            price: price[item].toString(),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllCategories(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: white,
                ),
              )
            : SubscriptionTestWidget(
                subscribeTab: subscribeTab,
              );
      },
    );
  }
}

class SubscriptionTestWidget extends StatelessWidget {
  SubscriptionTestWidget({this.subscribeTab});
  final List<Widget> subscribeTab;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoappBar(),
      drawer: Mydrawer(),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Subscription",
              style: TextStyle(
                  color: black, fontSize: 21, fontWeight: FontWeight.w600),
            ),

            Column(
              children: subscribeTab,
            )
          ],
        ),
      ),
    );
  }
}

class SubscriptionBox extends StatefulWidget {
  SubscriptionBox({this.duration, this.price});
   String price;
   String duration;


  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionBox> {
  String _error;
  Token _paymentToken;
  String email;
  @override
  void initState() {
    super.initState();
    checkUserAuthenticate();
    checkUserId();
    checkUserSub();
    checkEmail();
    checkUserPrice();
    StripePayment.setOptions(
        StripeOptions(publishableKey: "pk_test_51IX1o4SB0gSsu8cg4mxASlX5BgEFJO7NYfVbNHnfRHmps8tOzn8XoP14yl894TJv3vC2pxSRSduMaE5gzo2XRxLW00gYpG8hHv",
            merchantId: "",
            androidPayMode: "test"
        ));
  }

  bool authenticate;
  Future checkUserAuthenticate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("authenticated") != null) {
      setState(() {
        authenticate = pref.getBool("authenticated");
        print(authenticate);
      });
    }
  }
  PaymentMethod _paymentMethod;
  void setError(dynamic error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
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
        print(userId);
      });
    }
  }

  int price;
  Future checkUserPrice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("price") != null) {
      setState(() {
        price = pref.getInt("price");
        print(price.toString());
      });
    }
  }

  String sub;
  Future checkUserSub() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("sub") != null) {
      setState(() {
        sub = pref.getString("sub");
        print(sub);
      });
    }
  }

  Future checkEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("email") != null) {
      setState(() {
        email = pref.getString("email");
        print(email);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 2,
      child:price==int.parse(widget.price)? Container(
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
              decoration: BoxDecoration(color: Color(0xffFF9900)),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 8,
              ),
              child: Text(
                widget.duration.toString(),
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
                    "INR" + "  ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    "${widget.price.toString()}" + "/-",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),

            GestureDetector(
              onTap: () async {
                print("Tab");
                print(price.toString());
                print( widget.duration.toString());
                if(authenticate==true) {
                  if (sub != "yes") {
                    var response = await StripeService.payWithNewCard(
                      amount: widget.price.toString(),
                      currency: 'INR',
                    );
                    print(response.message);
                    print(response.paymentid);
                    if(response.message=="Transaction successful") {
                      final uri = "https://api.shott.tech/api/stripepaymentmobile";
                      final headers = {
                        'Content-Type': 'application/x-www-form-urlencoded'
                      }; //if required
                      print(userId.toString());
                      Response getResponse = await post(uri, headers: headers,body: {
                        "receipt_email":email,
                        // "source":response.paymentid,
                        "userid":userId.toString(),
                        "amount":widget.price.toString(),
                        //"plan":"1",
                        "paymentid":response.paymentid,
                        "duration":widget.duration.toString()
                      });
                      String responseBody = getResponse.body;
                      var data = json.decode(responseBody);
                      print(data);
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString("sub", "yes");
                      String startDate = DateTime.now().toString();
                      String enddate = data["subscriptiondetail"][2]["enddate"] ?? "NA";
                      int price=data["subscriptiondetail"]["price"];
                      pref.setInt("price", price);
                      pref.setString("sd", startDate);
                      pref.setString("ed", enddate);

                      print(response.message);
                      Fluttertoast.showToast(
                          msg: "Your subscription for 3 Months has started.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Already subscribe",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPageFromDrawer()));
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
      ):Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 12,
          ),
          child:Material(
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
                    decoration: BoxDecoration(color: Color(0xffFF9900)),
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
                  Center(
                    child: Text(
                      "This Subscription is \n currently active.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
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
    );
  }
}
