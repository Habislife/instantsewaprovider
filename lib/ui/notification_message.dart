import 'package:flutter/material.dart';
import 'package:provider/widgets/messaging_widget.dart';


class NotificationMessage extends StatelessWidget {
  const NotificationMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: MessagingWidget(),
    );
  }
}
