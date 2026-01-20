import 'package:expense_tracker_app/features/notification/notification_initializer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  /// Called when user adds income or expense
  static Future<void> showTransactionNotification({
    required String title,
    required String body,
  }) async {
    const andriodDetails = AndroidNotificationDetails(
      'transaction_channel',
      "Transactions",
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: andriodDetails,
      iOS: iosDetails,
    );

    await NotificationInitializer.plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000 ,  // unique ID
      title,
      body,
      notificationDetails,
    );
  }
}
