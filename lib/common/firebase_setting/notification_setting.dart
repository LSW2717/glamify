import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import 'firebase_options.dart';

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await showFlutterNotification(message);
}


Future<void> initFlutterLocalNotificationsPlugin() async {
  if (!isFlutterLocalNotificationsInitialized) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    var initialzationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initialzationSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid,
      iOS: initialzationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }
}

Future<String?> getToken(FirebaseMessaging instance) async {
  if (!isFlutterLocalNotificationsInitialized) {
    String? fcmToken = await instance.getToken();
    print('fcmToken : ${fcmToken ?? 'token NULL!'}');
    isFlutterLocalNotificationsInitialized = true;
    return fcmToken;
  }
  return null;
}

Future<void> getPermission(FirebaseMessaging instance) async {
  await instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<void> showFlutterNotification(RemoteMessage message) async{
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  AppleNotification? apple = message.notification?.apple;
  if (notification != null && android != null && Platform.isAndroid) {
    // 웹, ios가 아니면서 안드로이드이고, 알림이 있는경우
   await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
        ),
      ),
    );
  }

  if (notification != null && apple != null && Platform.isIOS) {
   await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          sound: 'default',
          badgeNumber: 1,
        ),
      ),
    );
  }
}