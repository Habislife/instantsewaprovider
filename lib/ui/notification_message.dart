import 'package:flutter/material.dart';
import 'package:provider/state/notification_state.dart';
import 'package:provider/util/hexcode.dart';
import 'package:provider/widgets/messaging_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class NotificationMessage extends StatelessWidget {
  const NotificationMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _notificationState = RM.get<NotificationState>();
    Color _purple = HexColor('#603f8b');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: _purple,
        title: Text('Notification'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () async {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Confirmation"),
                        content:
                        const Text("Are you sure you want to delete this notification?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _notificationState.setState((notificationState) => notificationState.deleteAllNotification());
                              _notificationState.setState((notificationState) => notificationState.getNotification());
                              Navigator.of(context).pop(false);
                            },
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
                    }
                );
              }
          ),
        ],
      ),
      body: MessagingWidget(),
    );
  }
}
