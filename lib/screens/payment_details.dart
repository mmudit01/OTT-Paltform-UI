import 'package:flutter/material.dart';
import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/models/movie.dart';
import 'package:shott_app/services/apiProvider.dart';

class PaymentStatus extends StatefulWidget {
  final String movieid;
  String link;
  PaymentStatus({this.movieid, this.link});
  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: orangeColor),
          title: Text(
            "Payment Details",
            style: TextStyle(
                color: black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/paymentsuccess_icon.png",
                width: 50,
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Payment is Succesfull !",
                  style: TextStyle(
                      color: blueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: GestureDetector(
                    onTap: () async {
                      //print(widget.movieid);
                      //print(widget.link);
                      Movie movie =
                          await APIprovider().getMovieByid(widget.movieid);
                      Navigator.of(context).pushReplacementNamed("/playVideo",
                          arguments: widget.link);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      color: blueColor,
                      child: Center(
                        child: Text(
                          "Click to Watch Movie",
                          style: TextStyle(color: white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
