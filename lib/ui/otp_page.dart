import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 20,
                    left: 0,
                    child: Image.asset(
                      "images/main_top.png",
                      width: size.width * 0.50,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Verification",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      "You got the verification code? Enter the code below.",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "code",
                                  labelStyle: TextStyle(color: Colors.grey))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromRGBO(49, 39, 79, 1),
                    ),
                    child: Center(
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: Text(
                      "Didn't get any code?",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "resend",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
