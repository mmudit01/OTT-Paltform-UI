import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/button_sign_page.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/screens/mainScreen.dart';
import 'package:shott_app/screens/signUp_page.dart';
import 'package:shott_app/services/UserPorfile.dart';
import 'package:shott_app/services/authentication.dart';

class SignOutPageFromDrawer extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignOutPageFromDrawer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        return false;
      },
      child: Material(
        color: black,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 40.0, left: 40, right: 40, top: 60),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/shott_logo.png",
                    height: 80.0,
                    width: 120.0,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "SignOut",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: black,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Sign Out through following methods",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: black,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  button(context, "Sign Out with Google+", () {
                    AuthService().signOutGoogle().then((val) async {
                      //print("done");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    });

                    //   Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(builder: (_) => Web()));
                  }),
                  // button(context, "Sign in with Facebook", () { Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (_) =>DevelopmentScreen("Under Development")));}),
                  // button(context, "Sign in with Twitter", () {
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //       builder: (_) =>DevelopmentScreen("Under Development")));
                  // }),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
