import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/ui/balance_page.dart';
import 'package:provider/ui/categories_list_page.dart';
import 'package:provider/ui/feedback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/hexcode.dart';
import 'track_order_page.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String email;
  String userName;
  bool _isLoading;
  @override
  void initState() {
    _isLoading = false;
    _loadUserData();
    _isLoading = true;
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        userName = user['username'];
        email = user['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    return Drawer(
      child: ListView(children: <Widget>[
        (!_isLoading)
            ? new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              )
            : UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: _purple),
                accountName: Text(userName),
                accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'B',
                    style: TextStyle(color: _purple),
                  ),
                ),
              ),
        ListTile(
          title: Text('Home'),
          leading: Icon(Icons.home),
          trailing: Icon(Icons.arrow_right),
          onTap: () => Navigator.of(context).pop(),
        ),
        ListTile(
          title: Text('Services'),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AllCategoryList(),
            ),
          ),
        ),
        ListTile(
          title: Text('Balance'),
          leading: Icon(Icons.attach_money),
          trailing: Icon(Icons.arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BalancePage(),
            ),
          ),
        ),
        ListTile(
          title: Text('Feedback'),
          leading: Icon(Icons.feedback),
          trailing: Icon(Icons.arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => FeedbackPage(),
            ),
          ),
        ),
        ListTile(
          title: Text('About us'),
          leading: Icon(Icons.people),
          trailing: Icon(Icons.arrow_right),
        ),
      ]),
    );
  }
}
