import 'package:provider/application/classes/notification/notification.dart';
import 'package:provider/repositories/notification_repository.dart';

class NotificationState{
  final NotificationRepository _notificationRepository;
  NotificationState(this._notificationRepository): assert(_notificationRepository != null);
  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;
  Future getNotification() async
  {
    _notifications= await _notificationRepository.getNotification();
  }
  Future deleteAllNotification() async
  {
    _notificationRepository.deleteAllNotification();
  }
  Future deleteNotification(String notificationId) async
  {
    _notificationRepository.deleteNotification(notificationId);
  }
  Future readNotification(String notificationId) async
  {
  _notificationRepository.readNotification(notificationId);
  }
}