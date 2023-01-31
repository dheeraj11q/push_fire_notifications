import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_fire_notifications/pushnotification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PushFireNotifications(
      // fcmTokenGet: (token) {
      //   print("Token Here => $token");
      // },
      onNotification: (payload) {},
      onTapNotification: (payload) {},
      onTapAppTerminatedNotification: (payload) {},
      child: MaterialApp(
        title: 'Notifications',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notifications"),
      ),
      body: const Center(child: Text("You will get notificationd here!")),
    );
  }
}
