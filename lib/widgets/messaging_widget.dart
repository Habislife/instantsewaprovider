import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/state/notification_state.dart';
import 'package:provider/util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MessagingWidget extends StatefulWidget {
  const MessagingWidget({Key key}) : super(key: key);

  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}


class _MessagingWidgetState extends State<MessagingWidget> with AutomaticKeepAliveClientMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _notificationState = RM.get<NotificationState>();
  StreamSubscription iosSubscription;
  Color _purple = HexColor('#603f8b');
  @override
  void initState() {
    _notificationState.setState((notificationState) => notificationState.getNotification());
    super.initState();
    _firebaseMessaging.subscribeToTopic('tracking_notification');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    if (Platform.isIOS) {
      iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
        _saveDeviceToken();
      });
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
    }
    else
    {
      _saveDeviceToken();
    }
  }
  _saveDeviceToken() async
  {
    String fcmToken = await _firebaseMessaging.getToken();
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/deviceTokenUpdate", data: {
        "deviceToken": fcmToken
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }
  @override
  Widget build(BuildContext context)=>StateBuilder<NotificationState>(
    observe: ()=> _notificationState,
    builder: (context, model){
      return ListView(
        shrinkWrap: true,
        children: [
          ...model.state.notifications.map((notification) =>
              Dismissible(
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Confirmation"),
                        content:
                        const Text("Are you sure you want to delete this notification?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(
                              "Delete",
                              style: TextStyle(color: _purple),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: _purple),
                            ),
                          ),
                        ],
                      );

                    },
                  );
                },
                key: UniqueKey(),
                background: Container(
                  color: Colors.red[700],
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction){
                  _notificationState.setState((notificationState) => notificationState.deleteNotification(notification.id));
                  _notificationState.setState((notificationState) => notificationState.getNotification());
                },
                child: GestureDetector(
                  onTap: () async {
                    await _notificationState.setState((notificationState) => notificationState.readNotification(notification.id));
                    Navigator.pushNamed(RM.context, trackerRoute);
                  },
                  child: Card(
                    color: notification.readTime != null ? Colors.white:Colors.lightBlueAccent,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          notification.messageTitle,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          notification.messageBody,
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing:Text(
                          notification.updatedTime,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ],
      );
    },
  );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
