import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../application/InstantSewa_api.dart';
import '../application/classes/errors/common_error.dart';
import '../application/storage/localstorage.dart';
import '../application/storage/storage_keys.dart';


class MessagingWidget extends StatefulWidget {
  const MessagingWidget({Key key}) : super(key: key);

  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}


class _MessagingWidgetState extends State<MessagingWidget> with AutomaticKeepAliveClientMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //final _notificationState = RM.get<NotificationState>();
  //final List<Message> messages = [];
  StreamSubscription iosSubscription;
  @override
  void initState() {
    //_notificationState.setState((notificationState) => notificationState.getNotification());
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
    print(fcmToken);
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
  Widget build(BuildContext context)=>ListView(
  //   StateBuilder<TrackingState>(
  //   observe: () => _trackingState,
  //   builder: (context, model) {
  //     return ListView(
  //       shrinkWrap: true,
  //       children: [
  //         ...model.state.ongoingProject.map(
  //               (orders) => Column(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (BuildContext context) =>
  //                           OngoingPage(orderId: orders.id,
  //                               cartName: orders.cartName),
  //                     ),
  //                   );
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(4.0),
  //                   child: Container(
  //                     height:
  //                     (MediaQuery.of(context).size.height) * 0.15,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white10,
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                     child: Card(
  //                       elevation: 0.5,
  //                       child: Row(
  //                         mainAxisAlignment:
  //                         MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Column(
  //                               mainAxisAlignment:
  //                               MainAxisAlignment.center,
  //                               children: [
  //                                 Text(
  //                                   orders.cartName,
  //                                   style: GoogleFonts.openSans(
  //                                     textStyle: TextStyle(
  //                                       color: Colors.black87,
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.w600,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Text(
  //                                   DateFormat.yMMMMd()
  //                                       .add_jm()
  //                                       .format(orders.startTime),
  //                                   style: GoogleFonts.openSans(
  //                                     textStyle: TextStyle(
  //                                       color: Colors.black54,
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.w600,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Column(
  //                               mainAxisAlignment:
  //                               MainAxisAlignment.center,
  //                               children: [
  //                                 Icon(
  //                                   Icons.circle,
  //                                   color: orders.status == 'Pending'
  //                                       ? Colors.orangeAccent
  //                                       : orders.status == 'Ongoing'
  //                                       ? Colors.green
  //                                       : Colors.grey,
  //                                   size: 13,
  //                                 ),
  //                                 Text(
  //                                   orders.status,
  //                                   style: GoogleFonts.openSans(
  //                                     textStyle: TextStyle(
  //                                       color: Colors.black87,
  //                                       fontSize: 13,
  //                                       fontWeight: FontWeight.w500,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );
  //   },
  // ),
  );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
