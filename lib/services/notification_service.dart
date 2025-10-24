import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/prayer.dart';
import '../l10n/app_localizations.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Android permissions are handled automatically
  }

  static void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap
    // Notification tapped
  }

  static Future<void> schedulePrayerNotifications(
    Map<PrayerType, DateTime> prayerTimes,
    AppLocalizations l10n,
    {String Function(PrayerType)? prayerTitleBuilder,
     String Function(PrayerType)? reminderTitleBuilder,
     String Function(PrayerType)? prayerBodyBuilder,
     String Function(PrayerType)? reminderBodyBuilder}
  ) async {
    // Cancel existing notifications
    await _notifications.cancelAll();

    int notificationId = 0;

    for (var entry in prayerTimes.entries) {
      final prayerType = entry.key;
      final prayerTime = entry.value;

      // Skip if prayer time has already passed
      if (prayerTime.isBefore(DateTime.now())) {
        continue;
      }

      // Schedule notification at prayer time (with custom sound)
      await _scheduleNotification(
        id: notificationId++,
        title: prayerTitleBuilder?.call(prayerType) ?? l10n.prayerTimeTitle,
        body: prayerBodyBuilder?.call(prayerType) ?? l10n.prayerTimeBody(prayerType.displayName),
        scheduledTime: prayerTime,
        payload: 'prayer_${prayerType.name}',
        isPrayerTime: true, // Use custom tone.mp3 sound
        l10n: l10n,
      );

      // Schedule reminder 30 minutes after prayer time (with default sound)
      final reminderTime = prayerTime.add(const Duration(minutes: 30));
      if (reminderTime.isAfter(DateTime.now())) {
        await _scheduleNotification(
          id: notificationId++,
          title: reminderTitleBuilder?.call(prayerType) ?? l10n.prayerReminderTitle,
          body: reminderBodyBuilder?.call(prayerType) ?? l10n.prayerReminderBody(prayerType.displayName),
          scheduledTime: reminderTime,
          payload: 'reminder_${prayerType.name}',
          isPrayerTime: false, // Use default sound
          l10n: l10n,
        );
      }
    }
  }

  static Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
    bool isPrayerTime = false,
    AppLocalizations? l10n,
  }) async {
    final scheduledTZ = tz.TZDateTime.from(scheduledTime, tz.local);

    // Different sound settings for prayer time vs reminders
    final androidDetails = AndroidNotificationDetails(
      'prayer_channel',
      l10n?.prayerNotificationsChannel ?? 'إشعارات الصلاة',
      channelDescription: l10n?.prayerNotificationsDescription ?? 'إشعارات لأوقات الصلاة والتذكيرات',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: isPrayerTime ? RawResourceAndroidNotificationSound('tone') : null, // Use tone.mp3 for prayer time
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledTZ,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  static Future<void> showInstantNotification({
    required String title,
    required String body,
    AppLocalizations? l10n,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'instant_channel',
      l10n?.instantNotificationsChannel ?? 'الإشعارات الفورية',
      channelDescription: l10n?.instantNotificationsDescription ?? 'الإشعارات الفورية',
      importance: Importance.high,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      999,
      title,
      body,
      notificationDetails,
    );
  }
}

