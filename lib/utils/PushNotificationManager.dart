// import 'package:ASmartApp/utils/utility.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class PushNotificationManager {
//
//   BuildContext context;
//
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//
//   void initFirebaseMessaging() {
//     firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         Map mapNotification = message['notification'];
//         String title = mapNotification['title'];
//         String body = mapNotification['body'];
//
//         // ส่งไปหน้าอื่นๆ
//         Navigator.pushNamed(context, '/showtimedetail');
//         Utility.getInstance().showAlertDialog(
//           context,
//           'Pushnotification Data',
//           'aaa'
//         );
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         Map mapNotification = message['notification'];
//         String title = mapNotification['title'];
//         String body = mapNotification['body'];
//         Utility.getInstance().showAlertDialog(
//           context,
//           'Pushnotification Data',
//           'aaa'
//         );
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         Map mapNotification = message['notification'];
//         String title = mapNotification['title'];
//         String body = mapNotification['body'];
//         Utility.getInstance().showAlertDialog(
//           context,
//           'Pushnotification Data',
//           'aaaa'
//         );
//       },
//   );
//
//   firebaseMessaging.requestNotificationPermissions(
//       const IosNotificationSettings(sound: true, badge: true, alert: true));
//   firebaseMessaging.onIosSettingsRegistered
//       .listen((IosNotificationSettings settings) {
//     print("Settings registered: $settings");
//   });
//
//   // Subscribe to firebase
//   firebaseMessaging.subscribeToTopic('news');
//
//   firebaseMessaging.getToken().then((String token) {
//     assert(token != null);
//     print("Token : $token");
//   });
//
//   }
//
// }