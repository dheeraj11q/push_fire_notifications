// import 'package:flutter/material.dart';
// import 'firebase_notification_api.dart';
// import 'local_notification_api.dart';

// class PushNotification extends StatefulWidget {
//   final Widget child;
//   final Function(String token)? fcmTokenGet;
//   final Function(String payload)? onNotification;
//   final Function(String payload)? onTapNotification;
//   final Function(String payload)? onTapAppTerminatedNotification;
//   const PushNotification(
//       {Key? key,
//       required this.child,
//       this.fcmTokenGet,
//       required this.onNotification,
//       required this.onTapNotification,
//       required this.onTapAppTerminatedNotification})
//       : super(key: key);

//   static bool foregroundNotificationEnable = true;

//   static void foregroundEnable(bool active) {
//     foregroundNotificationEnable = active;
//   }

//   @override
//   State<PushNotification> createState() => _PushNotificationState();
// }

// class _PushNotificationState extends State<PushNotification> {
//   @override
//   void initState() {
//     super.initState();
//     // FCM
//     if (widget.fcmTokenGet != null) {
//       FirebaseNotification.fcmTokenGet().then((token) {
//         widget.fcmTokenGet!(token);
//       });
//     }

//     // setting
//     FirebaseNotification.settings();

//     // init notificaton

//     FirebaseNotification.init(onNotification: ({String? payload}) {
//       widget.onNotification!(payload!);
//     }, onTapNotification: ({String? payload}) {
//       widget.onTapNotification!(payload!);
//     }, onTapTerminatedNotification: ({String? payload}) {
//       widget.onTapAppTerminatedNotification!(payload!);
//     });

//     // listen local notification tap
//     LocalNotificationApi.init();

//     listenNotification();
//   }

//   void listenNotification() {
//     LocalNotificationApi.onNotification.stream.listen((payload) {
//       widget.onTapNotification!(payload!);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
