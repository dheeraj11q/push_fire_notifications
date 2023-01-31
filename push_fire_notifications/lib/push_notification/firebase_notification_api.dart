import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../pushnotification.dart';
import 'local_notification_api.dart';

bool _foregroundNotificationEnable = true;

class FirebaseNotification {
  // [notification]

  static Future<String> fcmTokenGet() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    return fcmToken!;
  }

  static Future<void> settings() async {
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );
    }
  }

  static Future<void> init(
      {required Function({String payload}) onTapTerminatedNotification,
      required Function({String payload}) onTapNotification,
      required Function({String payload}) onNotification}) async {
    FirebaseMessaging.instance.requestPermission();

    // Todo when app is terminated

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        var data = json.encode(message.data);
        onTapTerminatedNotification(payload: data);
      }
    });

    // when app in foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null || android != null) {
          onNotification(payload: json.encode(message.data));
          if (_foregroundNotificationEnable) {
            LocalNotificationApi.showNotification(
                id: notification.hashCode,
                title: "${notification?.title}",
                body: "${notification?.body}",
                payload: json.encode(message.data));
          }

          foregroundEnable(true);
        }
      },
    );

    // when app is on background
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // when app is active onTap notification

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          onTapNotification(payload: json.encode(message.data));
        }
        if (notification != null && Platform.isIOS) {
          var data = json.encode(message.data);
          onTapNotification(payload: data);
        }
      },
    );
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  // print("on background");
}

void foregroundEnable(bool active) async {
  _foregroundNotificationEnable = active;
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: active,
  //   badge: active,
  //   sound: active,
  // );
}
