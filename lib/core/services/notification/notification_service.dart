import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';

class FirebaseNotification {
  final pref = SharedPreferencesMethod.storage;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? FCMToken;


  Future<void> initLocalNotification() async {
    var androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        print("Notification Received: $payload");
      },
    );
  }

  Future<void> firebaseInIt() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Message Title: ${message.notification!.title}");
        print("Message Body: ${message.notification!.body}");
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          "high_importance_channel",
          "High Importance Notification",
          importance: Importance.max,
        );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: "Your Channel Description",
          importance: Importance.high,
          priority: Priority.high,
          ticker: "ticker",
          icon: '@mipmap/ic_launcher',
        );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    // iOS natively handles foreground presentation if setForegroundNotificationPresentationOptions is true.
    // Calling this on iOS causes a duplicate notification banner.
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    }
  }
 Future<void> initNotification() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Set foreground notification options specifically for iOS
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    try {
      FCMToken = await messaging.getToken();
      pref.setString(LocalDBKeys.FCMTOKEN, FCMToken ?? '');
      print("User granted permission: ${settings.authorizationStatus}");
      print("Initial Token: $FCMToken");
      print("Shared Prefrences : ${pref.getString(LocalDBKeys.FCMTOKEN)}");
    } catch (e) {
      print("Error getting FCM Token (APNs may not be configured): $e");
    }
 }
  void onTokenRefresh() {
    messaging.onTokenRefresh.listen((newToken) {
      FCMToken = newToken;
      pref.setString(LocalDBKeys.FCMTOKEN, FCMToken ?? '');
      print("Token refreshed: $FCMToken");
      print("Shared Prefrences : ${pref.getString("FCMTOKEN")}");
    });
  }

}
