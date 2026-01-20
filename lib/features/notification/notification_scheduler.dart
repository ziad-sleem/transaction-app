import 'package:expense_tracker_app/features/notification/notification_initializer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScheduler {
  ///Schedule daily reminder at a fixed time
  ///Example: 9:00
  static Future<void> scheduleDailyReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Daily Reminders',
      channelDescription: 'Your reminder to add your transactions',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await NotificationInitializer.plugin.periodicallyShow(
      999, // fixed id for reminder
      'Daily Reminder ⏰',
      "Your reminder to add your transactions",
      RepeatInterval.daily,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}
