import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:instantsewa/state/auth_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool _onEditing = true;
  String _code;
  final _authStateRM = RM.get<AuthState>();
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
                  // Text(
                  //   "Verification",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Color.fromRGBO(49, 39, 79, 1),
                  //       fontSize: 30),
                  // ),
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
                  Center(
                    child: VerificationCode(
                      textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
                      underlineColor: Colors.amber,
                      keyboardType: TextInputType.number,
                      length: 5,
                      // clearAll is NOT required, you can delete it
                      // takes any widget, so you can implement your design
                      clearAll: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'clear all',
                          style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue[700]),
                        ),
                      ),
                      onCompleted: (String value) {
                        setState(() {
                          _code = value;
                          _authStateRM.setState((verify) => verify.verificationCode(
                            verificationToken:_code,
                          ));
                        });
                      },
                      onEditing: (bool value) {
                        setState(() {
                          _onEditing = value;
                        });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
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
                    child: FlatButton(
                      onPressed: () {
                        _authStateRM.setState((verify) => verify.resendVerificationCode());
                      },
                      child: Text(
                        "resend",
                        style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                      ),
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