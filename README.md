<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Push notification is a notification handling package. you can use it with firebase. it makes helps to readable code and decreases the time to implement push notifications.

## Features

Only one widget can implement push notifications.

## Getting started


start using the package.

First, integrate firebase into your flutter project

After all setup of firebase import this package 

Wrap MaterialApp with PushFireNotification widget 

Use these function onNotification, onTapNotification, 
onTapAppTerminatedNotification

That's it you have implemented push notification!


## Use Snippet

```
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return PushFireNotifications(
      fcmTokenGet: (String token) {
          // Here we can get FCM token when app starts.
      },
      onNotification: (String payload) {

        // This function trigger whenever notification occurs
        // get data in payload
      
      },
      onTapNotification: (String payload) {

        // This function use for on tap notification when app
        // is running mode
        
      },
      onTapAppTerminatedNotification: (String payload) {
         // This function use for on tap notification when 
         // app is terminated mode
      },
      child: MaterialApp(
        title: 'Flutter',
        debugShowCheckedModeBanner: true,
        Home: Home()
       
      
      ),
    );
  }
}
```

## Additional information
for more information visit 
https://github.com/dheeraj11q/pushnotification


