import 'package:flutter/material.dart';
import 'package:provider/ui/notification_message.dart';
import 'package:provider/ui/profile_page.dart';
import 'package:provider/ui/track_order_page.dart';
import 'package:provider/util/hexcode.dart';

import 'track_order_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool val1 = false;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _widgetList = [
    TrackOrder(),
    NotificationMessage(),
    ProfilePage(),

  ];

  int _index = 0;
  Color _purple = HexColor('#603f8b');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 54.0,
        child: BottomNavigationBar(
          selectedItemColor: _purple,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Orders'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text('Notification'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
      body: _widgetList[_index],
    );
  }
}
