import 'package:dio/dio.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/classes/notification/notification.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';


abstract class NotificationRepository{
  Future<List<Notification>> getNotification();
  Future deleteAllNotification();
  Future deleteNotification(String notificationId);
  Future readNotification(String notificationId);
}
class NotificationRepositoryImpl implements NotificationRepository{
  @override
  Future<List<Notification>> getNotification() async {
    try{
      final response = await InstantSewaAPI.dio.get("/notification",options: Options(
          headers: {
            'Authorization':"Bearer ${LocalStorage.getItem(TOKEN)}"
          }
      ));
      List _temp = response.data;
      List<Notification> _notifications = _temp.map((_notification) => Notification.fromJson(_notification)).toList();
      return _notifications;

    }on DioError catch(e){
      throw showNetworkError(e);
    }
  }

  @override
  Future deleteAllNotification()  async {
    try{
      final response = await InstantSewaAPI.dio.get("/deleteMyNotification",options: Options(
          headers: {
            'Authorization':"Bearer ${LocalStorage.getItem(TOKEN)}"
          }
      ));
    }on DioError catch(e){
      throw showNetworkError(e);
    }
  }

  @override
  Future deleteNotification(String notificationId) async {
    try {
      Response response = await InstantSewaAPI.dio
          .post("/deleteNotification", data: {
        "notification_id": notificationId,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

  @override
  Future readNotification(String notificationId) async {
    try {
      Response response = await InstantSewaAPI.dio
          .post("/readNotification", data: {
        "notification_id": notificationId,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

}