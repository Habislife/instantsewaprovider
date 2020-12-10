import 'package:intl/intl.dart';

class OperationTracker {
  String id;
  String cartName;
  DateTime startTime;
  String status;

  OperationTracker.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['identifier'].toString(),
        cartName = jsonMap['cartGroupName'],
        startTime = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonMap['startTime']),
        status = jsonMap['status'];
}
