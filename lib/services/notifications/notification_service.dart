abstract class NotificationService {
  const NotificationService();
  Future<void> requestPermission();
  Future<void> initialize(onDidReceiveNotificationResponse);
  Future<void> sendNotification(
      {required String title, required String body, required String payload});
}
