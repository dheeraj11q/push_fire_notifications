part of pushnotification;

class PushFireNotifications extends StatefulWidget {
  final Widget child;
  final Function(String token)? fcmTokenGet;
  final Function(String payload)? onNotification;
  final Function(String payload)? onTapNotification;
  final Function(String payload)? onTapAppTerminatedNotification;
  const PushFireNotifications(
      {Key? key,
      required this.child,
      this.fcmTokenGet,
      required this.onNotification,
      required this.onTapNotification,
      required this.onTapAppTerminatedNotification})
      : super(key: key);
  // static bool foregroundNotificationEnable = true;
  // static void foregroundEnable(bool active) async {
  //   foregroundNotificationEnable = active;
  // }

  @override
  State<PushFireNotifications> createState() => _PushFireNotificationsState();
}

class _PushFireNotificationsState extends State<PushFireNotifications> {
  @override
  void initState() {
    super.initState();
    // FCM
    if (widget.fcmTokenGet != null) {
      FirebaseNotification.fcmTokenGet().then((token) {
        widget.fcmTokenGet!(token);
      });
    }

    // setting
    FirebaseNotification.settings();

    // init notificaton

    FirebaseNotification.init(onNotification: ({String? payload}) {
      widget.onNotification!(payload!);
    }, onTapNotification: ({String? payload}) {
      widget.onTapNotification!(payload!);
    }, onTapTerminatedNotification: ({String? payload}) {
      widget.onTapAppTerminatedNotification!(payload!);
    });

    // listen local notification tap
    LocalNotificationApi.init();

    listenNotification();
  }

  void listenNotification() {
    LocalNotificationApi.onNotification.stream.listen((payload) {
      widget.onTapNotification!(payload!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
