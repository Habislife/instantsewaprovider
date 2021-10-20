import 'package:flutter/material.dart';
import 'package:provider/util/hexcode.dart';

class RechargePage extends StatefulWidget {
  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  @override
  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recharge'),
        backgroundColor: _purple,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 225,
                      child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 4.0, bottom: 4.0, right: 40.0, left: 7.0),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: ClipRect(
                                child: Image.asset(
                                  "images/photos/cash.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Rs 50",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        textColor: Colors.white,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 225,
                      child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 4.0, bottom: 4.0, right: 40.0, left: 7.0),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: ClipRect(
                                child: Image.asset(
                                  "images/photos/cash.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Rs 150",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        textColor: Colors.white,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 225,
                      child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 4.0, bottom: 4.0, right: 40.0, left: 7.0),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: ClipRect(
                                child: Image.asset(
                                  "images/photos/cash.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Rs 200",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        textColor: Colors.white,
                        color: Colors.green,
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
