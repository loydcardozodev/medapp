import 'package:medapp/domain/models/app_notification/app_notification.dart';
import 'package:medapp/util/result.dart';

abstract class NotificationRepository {
  Future<Result<List<AppNotification>>> getNotifications(String userId);
  Future<Result<void>> markAsRead(String notificationId);
}
