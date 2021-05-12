import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/button_sign_page.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/screens/LoginSignupFromDrawer/signUp_page.dart';
import 'package:shott_app/screens/mainScreen.dart';
import 'package:shott_app/screens/signUp_page.dart';
import 'package:shott_app/services/UserPorfile.dart';
import 'package:shott_app/services/authentication.dart';

class SignInPageDrawer extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPageDrawer> {
  List<String> favList;
  Future checkUserFav() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("favoritesList") != null) {
      setState(() {
        favList = pref.getStringList("favoritesList");
        //print(favList);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    checkUserFav();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                    "Signin",
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
                    "Sign in through following methods",
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
                button(context, "Sign in with Google+", () {
                  AuthService().signInWithGoogle().then((val) async {
                    if (val != null) {
                      Provider.of<UserProfile>(context, listen: false).setData(
                        name: val.displayName,
                        username: val.displayName,
                        phoneNo: val.phoneNumber,
                        email: val.email,
                        loginType: "Google",
                      );

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("authenticated", true);
                      prefs.setString("name", val.displayName);
                      prefs.setString("email", val.email);
                      prefs.setString("phoneno", val.phoneNumber ?? "NA");
                      prefs.setString("type", "Google");

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    }
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Don't have an Account? Register One!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: black,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => SignUpPageFromDrawer()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 40,
                        color: blueColor,
                        child: Center(
                          child: Text(
                            "Register an Account",
                            style: TextStyle(color: white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
