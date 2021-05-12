import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/appBar_shott.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/models/Category.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/screens/LoginSignupFromDrawer/signUp_page.dart';
import 'package:shott_app/services/apiProvider.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'mainScreen.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  List<Widget> subscribeTab = [];
  Future<void> getAllCategories() async {
    List<String> duration = [];

    Map<String, String> price = {};

    Map<String, dynamic> list = await APIprovider().subscription();
    price = list['price'];
    duration = list["duration"];

    for (var item in duration) {
      subscribeTab.add(
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
                      decoration: BoxDecoration(color: Color(0xffFF9900)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 8,
                      ),
                      child: Text(
                        item.toString(),
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
                            "${price[item].toString()}" + "/-",
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
                      onTap: () {
                        if (authenticate == true) {
                          if (sub != "yes") {
                            StripePayment.paymentRequestWithNativePay(
                              androidPayOptions: AndroidPayPaymentRequest(
                                totalPrice: price[item].toString(),
                                currencyCode: "EUR",
                              ),
                              applePayOptions: ApplePayPaymentOptions(
                                countryCode: 'DE',
                                currencyCode: 'EUR',
                                items: [
                                  ApplePayItem(
                                    label: 'Test',
                                    amount: '27',
                                  )
                                ],
                              ),
                            ).then((token) async {
                              Fluttertoast.showToast(
                                  msg: 'Received ${token.tokenId}',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received ${token.tokenId}')));
                              _paymentToken = token;
                            }).catchError(setError);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Already subscribe",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPageFromDrawer()));
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
      );
    }
  }

  String _error;
  Token _paymentToken;
  @override
  void initState() {
    super.initState();
    checkUserAuthenticate();
    checkUserId();
    checkUserSub();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IX1o4SB0gSsu8cg4mxASlX5BgEFJO7NYfVbNHnfRHmps8tOzn8XoP14yl894TJv3vC2pxSRSduMaE5gzo2XRxLW00gYpG8hHv",
        merchantId: "",
        androidPayMode: "test"));
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
    return FutureBuilder(
      future: getAllCategories(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: white,
                ),
              )
            : SubscriptionPageWidget(
                subscribeTab: subscribeTab,
              );
      },
    );
  }
}

class SubscriptionPageWidget extends StatelessWidget {
  SubscriptionPageWidget({this.subscribeTab});
  final List<Widget> subscribeTab;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoappBar(),
      drawer: Mydrawer(),
      backgroundColor: white,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Subscription",
                style: TextStyle(
                    color: black, fontSize: 21, fontWeight: FontWeight.w600),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Text(
              //     "",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              Column(
                children: subscribeTab,
              )
            ],
          ),
        ),
      ),
    );
  }
}
