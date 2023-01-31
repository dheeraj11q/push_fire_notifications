import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

// [for loacal notification]
class LocalNotificationApi {
  static final _flutterLocalNotifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "channel id,",
          "channel name",
          channelDescription: "channel description",
          importance: Importance.max,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: IOSNotificationDetails());
  }

  // [for onSelect notification initialize]
  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _flutterLocalNotifications.initialize(settings,
        onSelectNotification: (payload) {
      onNotification.add(payload);
    });
  }

  // [for show notification loacal]
  static Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    _flutterLocalNotifications.show(0, title, body, _notificationDetails(),
        payload: payload);
  }
}
