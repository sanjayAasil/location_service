import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:permission_handler/permission_handler.dart';

import '../common/global.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Icon for the notification

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _notificationConfig(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'location_channel_id', // Channel ID
      'Location Service', // Channel name
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
    );
  }

  void showStartNotification() {
    _notificationConfig("Location Service", "Your Location Service Update has started");
  }

  void showStopNotification() {
    _notificationConfig("Location Service", "Your Location Service Update has stopped");
  }

  Future<void> requestNotificationPermission(BuildContext context) async {
    // Check if location permission is granted
    var status = await Permission.notification.status;

    if (status.isGranted) {
      // Permission already granted
      if (context.mounted) {
        showToast(context, 'Notification permission already granted');
      }
    } else if (status.isDenied) {
      // Request permission
      status = await Permission.notification.request();

      if (status.isGranted) {
        if (context.mounted) {
          showToast(context, 'Notification permission granted');
        }
      } else if (status.isPermanentlyDenied) {
        // The user selected "Don't ask again"

        if (context.mounted) {
          showToast(context, 'Notification permission permanently denied. Open app settings');
        }
        openAppSettings();
      } else {
        if (context.mounted) {
          showToast(context, 'Notification permission denied');
        }
      }
    }
  }
}
