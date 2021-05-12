import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = new Dio();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      //print('signInWithGoogle succeeded: $user');
      try {
        var res = await http.post(
            Uri.encodeFull('https://api.shott.tech/api/googleauth'),
            headers: {
              "Accept": "application/json"
            },
            body: {
              "name": currentUser.displayName,
              "email": currentUser.email,
              "picture": currentUser.photoURL,
            });
        if (res.statusCode == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var data = json.decode(res.body);
          String userId = data["_id"];
          prefs.setString("userId", userId);
          if (data["subscriptiondetail"].length > 0) {
            String startDate =
                data["subscriptiondetail"][0]["startdate"] ?? "NA";
            String enddate = data["subscriptiondetail"][0]["enddate"] ?? "NA";
            int mobile = data["mobilenumber"];
            int price = data["subscriptiondetail"][0]["price"];
            if (startDate != "" || startDate != null) {
              prefs.setString("sub", "yes");
            }
            //print(startDate.toString());

            prefs.setString("sd", startDate);
            prefs.setString("ed", enddate);
            prefs.setInt("mobileNo", mobile ?? 0);
            prefs.setInt("price", price);
          }
          print(userId);
          print(data);
        }
        // var response =
        //     await dio.post('https://api.shott.tech/api/googleauth', data: {
        //   "name": currentUser.displayName,
        //   "email": currentUser.email,
        //   "picture": currentUser.photoURL,
        // });
        //
        // var data = json.decode(response.b);
        // String userId=data["_id"];
        // final SharedPreferences prefs =
        // await SharedPreferences.getInstance();
        // prefs.setString("userId", userId);
        //print("------------------------------");

      } on DioError catch (e) {
        //print(e);
      }

      return user;
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    //print("User Signed Out");
  }

  googleAuth() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication _googleauth = await _googleUser.authentication;
    //print(_googleUser.displayName);
    try {
      dynamic response =
          await dio.post('https://api.shott.tech/api/googleauth', data: {
        "name": _googleUser.displayName,
        "email": _googleUser.email,
        "picture": _googleUser.photoUrl,
      });
      //print("------------------------------");
      //print(response);
      return response;
    } on DioError catch (e) {
      //print(e);
    }

    // String url = 'https://admin.shott.tech/api/googleauth/';
    // String json =
    //     '{"googleID": ${_googleUser.id}, "name": ${_googleUser.displayName}, "email": ${_googleUser.email}, "picture": ${_googleUser.photoUrl}, "accesstoken": ${_googleauth.accessToken}}';
    // final response = await http.post(url, body: jsonEncode(json));
    // int statusCode = response.statusCode;
    // print(statusCode);
    // return statusCode;
  }
}
