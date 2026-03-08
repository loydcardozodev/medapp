import 'package:medapp/data/repository/notification_repository/notification_repository.dart';
import 'package:medapp/data/services/local/local_data_service.dart';
import 'package:medapp/domain/models/app_notification/app_notification.dart';
import 'package:medapp/util/result.dart';

class NotificationRepositoryLocal implements NotificationRepository {
  @override
  Future<Result<List<AppNotification>>> getNotifications(String userId) async {
    try {
      final notifications = LocalDataService.getNotifications(userId);
      return Result.ok(notifications);
    } catch (e) {
      return Result.error(Exception('Failed to fetch notifications: $e'));
    }
  }

  @override
  Future<Result<void>> markAsRead(String notificationId) async {
    try {
      LocalDataService.markNotificationAsRead(notificationId);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to mark notification as read: $e'));
    }
  }
}
